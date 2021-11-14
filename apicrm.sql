-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Янв 31 2021 г., 13:30
-- Версия сервера: 5.7.29
-- Версия PHP: 7.4.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `apicrm`
--

DELIMITER $$
--
-- Процедуры
--
CREATE DEFINER=`mysql`@`localhost` PROCEDURE `countLeads` (IN `p1` DATE, IN `p2` DATE)  BEGIN
SELECT
	users.id,
    users.firstname,
    users.lastname,
    COUNT(*) AS CountLeads,
    COUNT(IF(leads.isQualityLead='1', 1, null)) as CountQualityLeads,
    COUNT(IF(leads.isQualityLead='1' AND leads.is_add_sale='1', 1, null)) as CountQualityAssSaleLeads,
    COUNT(IF(leads.isQualityLead='0', 1, null)) as CountNotQualityLeads,
    COUNT(IF(leads.isQualityLead='0' AND leads.is_add_sale='1', 1, null)) as CountNotQualityAssSaleLeads
FROM
    leads
LEFT JOIN users ON(users.id = leads.user_id)
WHERE leads.created_at >= p1 AND leads.created_at <= p2  AND leads.status_id = '3'
GROUP BY users.id, users.firstname, users.lastname;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблицы `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `leads`
--

CREATE TABLE `leads` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `link` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `count_create` int(11) NOT NULL DEFAULT '1',
  `is_processed` tinyint(1) NOT NULL DEFAULT '0',
  `isQualityLead` tinyint(1) NOT NULL DEFAULT '0',
  `is_express_delivery` tinyint(1) NOT NULL DEFAULT '0',
  `is_add_sale` tinyint(1) NOT NULL DEFAULT '0',
  `source_id` bigint(20) UNSIGNED DEFAULT NULL,
  `unit_id` bigint(20) UNSIGNED DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `status_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `leads`
--

INSERT INTO `leads` (`id`, `phone`, `link`, `count_create`, `is_processed`, `isQualityLead`, `is_express_delivery`, `is_add_sale`, `source_id`, `unit_id`, `user_id`, `status_id`, `created_at`, `updated_at`) VALUES
(1, '1111111111', 'http://google.com', 1, 0, 0, 0, 0, 1, 1, 2, 1, '2020-12-29 20:49:08', '2020-12-29 20:49:08'),
(2, NULL, 'http://google.com', 1, 0, 0, 0, 0, 1, 1, 1, 1, '2020-12-31 10:44:50', '2020-12-31 10:44:50'),
(3, '11111111', NULL, 1, 0, 0, 0, 0, 1, 1, 1, 1, '2020-12-31 10:45:19', '2020-12-31 10:45:19'),
(4, NULL, 'http://site.com', 1, 0, 1, 0, 0, 1, 1, 1, 3, '2021-01-25 19:52:08', '2021-01-25 19:52:08'),
(5, NULL, 'http://site.com', 1, 0, 1, 0, 0, 1, 1, 1, 3, '2021-01-25 19:52:47', '2021-01-25 19:52:47'),
(6, NULL, 'http://site.com', 3, 0, 1, 0, 0, 2, 2, 2, 3, '2021-01-25 19:54:24', '2021-01-27 18:57:18');

-- --------------------------------------------------------

--
-- Структура таблицы `lead_comments`
--

CREATE TABLE `lead_comments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `text` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `lead_id` bigint(20) UNSIGNED DEFAULT NULL,
  `status_id` bigint(20) UNSIGNED DEFAULT NULL,
  `comment_value` text COLLATE utf8mb4_unicode_ci,
  `is_event` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `lead_comments`
--

INSERT INTO `lead_comments` (`id`, `text`, `user_id`, `lead_id`, `status_id`, `comment_value`, `is_event`, `created_at`, `updated_at`) VALUES
(1, 'Автор <strong> admin</strong> создал лид со статусом Новые заявки', 1, 4, 1, NULL, 1, '2021-01-25 19:52:08', '2021-01-25 19:52:08'),
(2, 'Пользователь <strong> admin</strong> оставил комментарий Hello world', 1, 4, 1, NULL, 0, '2021-01-25 19:52:08', '2021-01-25 19:52:08'),
(3, 'Автор <strong> admin</strong> создал лид со статусом Новые заявки', 1, 5, 1, NULL, 1, '2021-01-25 19:52:47', '2021-01-25 19:52:47'),
(4, 'Пользователь <strong> admin</strong> оставил комментарий Hello world', 1, 5, 1, NULL, 0, '2021-01-25 19:52:47', '2021-01-25 19:52:47'),
(5, 'Автор <strong> admin</strong> создал лид со статусом Новые заявки', 1, 6, 1, NULL, 1, '2021-01-25 19:54:24', '2021-01-25 19:54:24'),
(6, 'Пользователь <strong> admin</strong> оставил комментарий Hello world', 1, 6, 1, 'Hello world', 0, '2021-01-25 19:54:24', '2021-01-25 19:54:24'),
(7, 'Пользователь <strong> admin</strong> оставил комментарий Hello world', 1, 6, 1, 'Hello world', 0, '2021-01-26 19:48:46', '2021-01-26 19:48:46'),
(8, 'Пользователь <strong> admin</strong> изменил статус лида В работе', 1, 6, 2, NULL, 1, '2021-01-26 19:49:10', '2021-01-26 19:49:10'),
(9, 'Пользователь <strong> admin</strong> изменил автора лида на  Manager', 1, 6, 2, NULL, 1, '2021-01-26 19:49:56', '2021-01-26 19:49:56'),
(10, 'Пользователь  admin оставил комментарий Hello world', 1, 6, 1, 'Hello world', 0, '2021-01-26 20:10:34', '2021-01-26 20:10:34'),
(11, 'Пользователь  admin изменил статус на Новые заявки', 1, 6, 1, NULL, 1, '2021-01-26 20:10:34', '2021-01-26 20:10:34'),
(12, 'Автор  admin создал лид  со статусом Новые заявки', 1, 6, 1, 'Hello world', 1, '2021-01-26 20:10:34', '2021-01-26 20:10:34'),
(13, 'Пользователь  admin оставил комментарий Hello world 2', 1, 6, 1, 'Hello world 2', 0, '2021-01-26 20:11:46', '2021-01-26 20:11:46'),
(14, 'Пользователь  admin изменил источник на Viber', 1, 6, 1, NULL, 1, '2021-01-26 20:11:46', '2021-01-26 20:11:46'),
(15, 'Пользователь  admin изменил подразделение на Shop 2', 1, 6, 1, NULL, 1, '2021-01-26 20:11:46', '2021-01-26 20:11:46'),
(16, 'Автор  admin создал лид  со статусом Новые заявки', 1, 6, 1, 'Hello world 2', 1, '2021-01-26 20:11:46', '2021-01-26 20:11:46');

-- --------------------------------------------------------

--
-- Структура таблицы `lead_status`
--

CREATE TABLE `lead_status` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `lead_id` bigint(20) UNSIGNED DEFAULT NULL,
  `status_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `lead_status`
--

INSERT INTO `lead_status` (`id`, `lead_id`, `status_id`, `created_at`, `updated_at`) VALUES
(1, 5, 1, NULL, NULL),
(2, 6, 1, NULL, NULL),
(3, 6, 2, NULL, NULL),
(4, 6, 1, NULL, NULL),
(5, 6, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `menus`
--

CREATE TABLE `menus` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `parent` int(11) NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sort_order` int(11) NOT NULL DEFAULT '100',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `menus`
--

INSERT INTO `menus` (`id`, `title`, `path`, `parent`, `type`, `sort_order`, `created_at`, `updated_at`) VALUES
(3, 'Dashboard', '/', 0, 'admin', 100, NULL, NULL),
(5, 'Roles', 'roles.index', 0, 'admin', 100, NULL, NULL),
(6, 'Permissions', 'permissions.index', 0, 'admin', 100, NULL, NULL),
(7, 'Users', 'users.index', 0, 'admin', 100, NULL, NULL),
(8, 'Dashboard', '/', 0, 'front', 100, NULL, NULL),
(9, 'Form', 'form', 0, 'front', 100, NULL, NULL),
(10, 'Users', 'users', 0, 'front', 100, NULL, NULL),
(11, 'Sources', 'sources', 0, 'front', 100, NULL, NULL),
(12, 'Units', 'units', 0, 'front', 100, NULL, NULL),
(13, 'Lead Archive', 'archives', 0, 'front', 100, NULL, NULL),
(14, 'Analitics', 'analitics', 0, 'front', 100, NULL, NULL),
(15, 'Tasks', 'tasks', 0, 'front', 100, NULL, NULL),
(16, 'Task Archive', 'task_archives', 0, 'front', 100, NULL, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_100000_create_password_resets_table', 1),
(2, '2019_08_19_000000_create_failed_jobs_table', 1),
(3, '2016_06_01_000001_create_oauth_auth_codes_table', 2),
(4, '2016_06_01_000002_create_oauth_access_tokens_table', 2),
(5, '2016_06_01_000003_create_oauth_refresh_tokens_table', 2),
(6, '2016_06_01_000004_create_oauth_clients_table', 2),
(7, '2016_06_01_000005_create_oauth_personal_access_clients_table', 2),
(8, '2020_10_29_213949_create_users_table', 3),
(10, '2020_11_29_124012_create_menus_table', 4),
(11, '2020_12_13_065918_create_roles_table', 5),
(12, '2020_12_13_070523_create_permissions', 5),
(13, '2020_12_13_070544_create_role_permissions', 5),
(14, '2020_12_20_120133_add_permission_menu_table', 6),
(15, '2020_12_26_155516_create_sources_table', 7),
(21, '2020_12_27_084610_create_statuses_table', 8),
(22, '2020_12_27_084612_c_reate_units_t_able', 8),
(23, '2020_12_27_084614_create_leads_table', 8),
(24, '2020_12_27_093705_create_lead_comments_table', 9),
(25, '2021_01_25_214805_create_lead_status_table', 10),
(27, '2021_01_28_210553_create_analitics_table', 11),
(29, '2019_03_25_113115_create_tasks_table', 12),
(30, '2019_03_25_120525_change_task', 12),
(31, '2019_03_25_120925_create_task_comments_table', 13);

-- --------------------------------------------------------

--
-- Структура таблицы `oauth_access_tokens`
--

CREATE TABLE `oauth_access_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `client_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `oauth_access_tokens`
--

INSERT INTO `oauth_access_tokens` (`id`, `user_id`, `client_id`, `name`, `scopes`, `revoked`, `created_at`, `updated_at`, `expires_at`) VALUES
('97693443221076f2e85a3faf9725085910a1a4f4d2f44914da364ec9b0b7a6da987f8f4072f417e6', 1, 1, 'Personal Access Token', '[]', 0, '2020-11-15 06:41:13', '2020-11-15 06:41:13', '2021-11-15 08:41:13'),
('d2dd0d1d6ba55b02caf1bb997325fa3a707c44ed3a1f23511dcf0cab4fbf274dc74b20b088667ee0', 1, 1, 'Personal Access Token', '[]', 0, '2020-12-13 04:39:47', '2020-12-13 04:39:47', '2021-12-13 06:39:47'),
('ef690b84a673cddd311d1ea6c013538355ebe2d7df857d5b8725779369865a6212f7249252553360', 1, 1, 'Personal Access Token', '[]', 0, '2020-12-12 05:40:21', '2020-12-12 05:40:21', '2021-12-12 07:40:21');

-- --------------------------------------------------------

--
-- Структура таблицы `oauth_auth_codes`
--

CREATE TABLE `oauth_auth_codes` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `client_id` bigint(20) UNSIGNED NOT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `oauth_clients`
--

CREATE TABLE `oauth_clients` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `provider` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `redirect` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `oauth_clients`
--

INSERT INTO `oauth_clients` (`id`, `user_id`, `name`, `secret`, `provider`, `redirect`, `personal_access_client`, `password_client`, `revoked`, `created_at`, `updated_at`) VALUES
(1, NULL, 'Laravel Personal Access Client', 'QO5ywLPb1mHUE1GIeHTkPTL9cEjAQb6H3AQgMBDi', NULL, 'http://localhost', 1, 0, 0, '2020-10-28 19:47:05', '2020-10-28 19:47:05'),
(2, NULL, 'Laravel Password Grant Client', 'w7CMZpxL0I1VimonJ9OD0L4CDHjzRmN6FwU2vgyM', 'users', 'http://localhost', 0, 1, 0, '2020-10-28 19:47:05', '2020-10-28 19:47:05');

-- --------------------------------------------------------

--
-- Структура таблицы `oauth_personal_access_clients`
--

CREATE TABLE `oauth_personal_access_clients` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `client_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `oauth_personal_access_clients`
--

INSERT INTO `oauth_personal_access_clients` (`id`, `client_id`, `created_at`, `updated_at`) VALUES
(1, 1, '2020-10-28 19:47:05', '2020-10-28 19:47:05');

-- --------------------------------------------------------

--
-- Структура таблицы `oauth_refresh_tokens`
--

CREATE TABLE `oauth_refresh_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `permissions`
--

CREATE TABLE `permissions` (
  `id` int(10) UNSIGNED NOT NULL,
  `alias` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `permissions`
--

INSERT INTO `permissions` (`id`, `alias`, `title`, `created_at`, `updated_at`) VALUES
(1, 'SUPER_ADMINISTRATOR', 'Super Administrator', NULL, NULL),
(2, 'ROLES_ACCESS', 'Role Access', NULL, NULL),
(3, 'USER_ACCESS', 'USER_ACCESS', NULL, NULL),
(4, 'SOURCES_ACCESS', 'SOURCES ACCESS', NULL, NULL),
(5, 'LEADS_CREATE', 'LEADS CREATE', NULL, NULL),
(6, 'LEADS_EDIT', 'LEADS EDIT', NULL, NULL),
(7, 'LEADS_ACCESS', 'LEADS ACCESS', NULL, NULL),
(8, 'DASHBOARD_ACCESS', 'DASHBOARD ACCESS', NULL, NULL),
(9, 'LEADS_COMMENT_ACCESS', 'LEADS COMMENT ACCESS', NULL, NULL),
(10, 'ANALITICS_ACCESS', 'ANALITICS ACCESS', NULL, NULL),
(11, 'TASKS_VIEW', 'TASKS VIEW', NULL, NULL),
(12, 'TASKS_CREATE', 'TASKS CREATE', NULL, NULL),
(13, 'TASKS_EDIT', 'TASKS EDIT', NULL, NULL),
(14, 'TASKS_COMMENT_VIEW', 'TASKS COMMENT VIEW', NULL, NULL),
(15, 'TASKS_COMMENT_CREATE', 'TASKS COMMENT CREATE', NULL, NULL),
(16, 'TASKS_COMMENT_EDIT', 'TASKS COMMENT EDIT', NULL, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `permission_menu`
--

CREATE TABLE `permission_menu` (
  `permission_id` int(10) UNSIGNED NOT NULL,
  `menu_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `permission_menu`
--

INSERT INTO `permission_menu` (`permission_id`, `menu_id`) VALUES
(1, 9),
(1, 12),
(1, 3),
(1, 5),
(1, 6),
(1, 7);

-- --------------------------------------------------------

--
-- Структура таблицы `permission_role`
--

CREATE TABLE `permission_role` (
  `id` int(10) UNSIGNED NOT NULL,
  `role_id` int(10) UNSIGNED NOT NULL,
  `permission_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `permission_role`
--

INSERT INTO `permission_role` (`id`, `role_id`, `permission_id`, `created_at`, `updated_at`) VALUES
(3, 3, 1, NULL, NULL),
(5, 2, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `roles`
--

CREATE TABLE `roles` (
  `id` int(10) UNSIGNED NOT NULL,
  `alias` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `roles`
--

INSERT INTO `roles` (`id`, `alias`, `title`, `created_at`, `updated_at`) VALUES
(2, 'SUPER_ADMINISTRATOR', 'Super Administrator', '2020-12-13 10:37:02', '2020-12-13 10:37:02'),
(3, 'MANAGER', 'Manager', '2020-12-13 10:51:57', '2020-12-13 10:51:57');

-- --------------------------------------------------------

--
-- Структура таблицы `role_user`
--

CREATE TABLE `role_user` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `role_id` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `role_user`
--

INSERT INTO `role_user` (`id`, `user_id`, `role_id`, `created_at`, `updated_at`) VALUES
(1, 1, 2, NULL, NULL),
(2, 2, 3, NULL, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `sources`
--

CREATE TABLE `sources` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `sources`
--

INSERT INTO `sources` (`id`, `title`, `created_at`, `updated_at`) VALUES
(1, 'Instagram', NULL, '2020-12-26 14:14:27'),
(2, 'Viber', NULL, NULL),
(3, 'Site', NULL, NULL),
(4, 'Phone', NULL, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `statuses`
--

CREATE TABLE `statuses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title_ru` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `statuses`
--

INSERT INTO `statuses` (`id`, `title`, `title_ru`, `created_at`, `updated_at`) VALUES
(1, 'new', 'Новые заявки', NULL, NULL),
(2, 'process', 'В работе', NULL, NULL),
(3, 'done', 'Выполнено', NULL, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `tasks`
--

CREATE TABLE `tasks` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `link` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `source_id` bigint(20) UNSIGNED DEFAULT NULL,
  `unit_id` bigint(20) UNSIGNED DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `responsible_id` bigint(20) UNSIGNED DEFAULT NULL,
  `status_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `tasks`
--

INSERT INTO `tasks` (`id`, `phone`, `link`, `source_id`, `unit_id`, `user_id`, `responsible_id`, `status_id`, `created_at`, `updated_at`) VALUES
(1, NULL, 'http://gogole.com', 1, 1, 1, 1, 1, '2021-01-31 06:34:15', '2021-01-31 06:34:15'),
(2, NULL, 'http://gogole.com', 1, 1, 1, 1, 1, '2021-01-31 06:35:12', '2021-01-31 06:35:12'),
(3, NULL, 'http://gogole.com', 1, 1, 1, 1, 3, '2021-01-27 06:35:37', '2021-01-28 07:02:49'),
(4, NULL, 'http://gogole1.com', 1, 1, 1, 1, 3, '2021-01-31 08:19:49', '2021-01-31 08:26:04');

-- --------------------------------------------------------

--
-- Структура таблицы `task_comments`
--

CREATE TABLE `task_comments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `text` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `task_id` bigint(20) UNSIGNED DEFAULT NULL,
  `status_id` bigint(20) UNSIGNED DEFAULT NULL,
  `comment_value` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `is_event` tinyint(4) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `task_comments`
--

INSERT INTO `task_comments` (`id`, `text`, `user_id`, `task_id`, `status_id`, `comment_value`, `created_at`, `updated_at`, `is_event`) VALUES
(1, 'Автор  admin создал адачу со статусом Новые заявки', 1, 3, 1, NULL, '2021-01-31 06:35:37', '2021-01-31 06:35:37', 1),
(2, 'Пользователь <strong> admin</strong> оставил <strong>комментарий</strong> New Task', 1, 3, 1, 'New Task', '2021-01-31 06:35:37', '2021-01-31 06:35:37', 0),
(3, 'Пользователь <strong> admin</strong> изменил <strong>статус</strong> на В работе', 1, 2, 2, NULL, '2021-01-31 06:59:52', '2021-01-31 06:59:52', 1),
(4, 'Пользователь <strong> admin</strong> оставил <strong>комментарий</strong> New comment', 1, 2, 2, 'New comment', '2021-01-31 06:59:52', '2021-01-31 06:59:52', 0),
(5, 'Пользователь <strong> admin</strong> изменил <strong>статус</strong> на Выполнено', 1, 2, 3, NULL, '2021-01-31 07:00:07', '2021-01-31 07:00:07', 1),
(6, 'Пользователь <strong> admin</strong> оставил <strong>комментарий</strong> New comment3', 1, 2, 3, 'New comment3', '2021-01-31 07:00:07', '2021-01-31 07:00:07', 0),
(7, 'Пользователь <strong> admin</strong> изменил <strong>статус</strong> на Выполнено', 1, 3, 3, NULL, '2021-01-31 07:01:50', '2021-01-31 07:01:50', 1),
(8, 'Пользователь <strong> admin</strong> оставил <strong>комментарий</strong> New comment3', 1, 3, 3, 'New comment3', '2021-01-31 07:01:50', '2021-01-31 07:01:50', 0),
(9, 'Пользователь <strong> admin</strong> изменил <strong>статус</strong> на Выполнено', 1, 3, 3, NULL, '2021-01-31 07:02:49', '2021-01-31 07:02:49', 1),
(10, 'Пользователь <strong> admin</strong> оставил <strong>комментарий</strong> New comment3', 1, 3, 3, 'New comment3', '2021-01-31 07:02:49', '2021-01-31 07:02:49', 0),
(11, 'Автор  admin создал адачу со статусом Новые заявки', 1, 4, 1, NULL, '2021-01-31 08:19:49', '2021-01-31 08:19:49', 1),
(12, 'Пользователь <strong> admin</strong> оставил <strong>комментарий</strong> New Task', 1, 4, 1, 'New Task', '2021-01-31 08:19:49', '2021-01-31 08:19:49', 0),
(13, 'Пользователь <strong> admin</strong> оставил <strong>комментарий</strong> New comment3', 1, 3, 3, 'New comment3', '2021-01-31 08:25:43', '2021-01-31 08:25:43', 0),
(14, 'Пользователь <strong> admin</strong> изменил <strong>статус</strong> на Выполнено', 1, 4, 3, NULL, '2021-01-31 08:26:04', '2021-01-31 08:26:04', 1),
(15, 'Пользователь <strong> admin</strong> оставил <strong>комментарий</strong> New comment3', 1, 4, 3, 'New comment3', '2021-01-31 08:26:04', '2021-01-31 08:26:04', 0);

-- --------------------------------------------------------

--
-- Структура таблицы `task_status`
--

CREATE TABLE `task_status` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `task_id` bigint(20) UNSIGNED DEFAULT NULL,
  `status_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `task_status`
--

INSERT INTO `task_status` (`id`, `task_id`, `status_id`, `created_at`, `updated_at`) VALUES
(1, 2, 1, NULL, NULL),
(2, 3, 1, NULL, NULL),
(3, 2, 2, NULL, NULL),
(4, 2, 3, NULL, NULL),
(5, 3, 3, NULL, NULL),
(6, 3, 3, NULL, NULL),
(7, 4, 1, NULL, NULL),
(8, 4, 3, NULL, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `units`
--

CREATE TABLE `units` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `units`
--

INSERT INTO `units` (`id`, `title`, `created_at`, `updated_at`) VALUES
(1, 'Shop 1', NULL, NULL),
(2, 'Shop 2', NULL, NULL),
(3, 'Shop 3', NULL, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `firstname` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lastname` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('0','1') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password`, `status`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'admin', 'admin@admin.com', '111111111111', '$2y$10$LEMd3STESyA42mGcPx4ikOXUW06tvHwaOBGaZJh6ezkV1pde5QGX6', '1', NULL, NULL),
(2, 'Manager', 'Manager', 'manager@manager.com', '1234567890', '$2y$10$Z0x9xA6GSDAauXK7syKyvuRVTxaqoEl5Qyl5a97yk8mJZD9EBjJEW', '0', '2020-12-26 07:04:23', '2020-12-26 07:22:03');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Индексы таблицы `leads`
--
ALTER TABLE `leads`
  ADD PRIMARY KEY (`id`),
  ADD KEY `leads_source_id_foreign` (`source_id`),
  ADD KEY `leads_unit_id_foreign` (`unit_id`),
  ADD KEY `leads_user_id_foreign` (`user_id`),
  ADD KEY `leads_status_id_foreign` (`status_id`);

--
-- Индексы таблицы `lead_comments`
--
ALTER TABLE `lead_comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lead_comments_user_id_foreign` (`user_id`),
  ADD KEY `lead_comments_lead_id_foreign` (`lead_id`),
  ADD KEY `lead_comments_status_id_foreign` (`status_id`);

--
-- Индексы таблицы `lead_status`
--
ALTER TABLE `lead_status`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lead_status_lead_id_foreign` (`lead_id`),
  ADD KEY `lead_status_status_id_foreign` (`status_id`);

--
-- Индексы таблицы `menus`
--
ALTER TABLE `menus`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `oauth_access_tokens`
--
ALTER TABLE `oauth_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_access_tokens_user_id_index` (`user_id`);

--
-- Индексы таблицы `oauth_auth_codes`
--
ALTER TABLE `oauth_auth_codes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_auth_codes_user_id_index` (`user_id`);

--
-- Индексы таблицы `oauth_clients`
--
ALTER TABLE `oauth_clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_clients_user_id_index` (`user_id`);

--
-- Индексы таблицы `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `oauth_refresh_tokens`
--
ALTER TABLE `oauth_refresh_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`);

--
-- Индексы таблицы `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Индексы таблицы `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `permission_menu`
--
ALTER TABLE `permission_menu`
  ADD KEY `permission_menu_permission_id_foreign` (`permission_id`),
  ADD KEY `permission_menu_menu_id_foreign` (`menu_id`);

--
-- Индексы таблицы `permission_role`
--
ALTER TABLE `permission_role`
  ADD PRIMARY KEY (`id`),
  ADD KEY `permission_role_role_id_foreign` (`role_id`),
  ADD KEY `permission_role_permission_id_foreign` (`permission_id`);

--
-- Индексы таблицы `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `role_user`
--
ALTER TABLE `role_user`
  ADD PRIMARY KEY (`id`),
  ADD KEY `role_user_role_id_foreign` (`role_id`),
  ADD KEY `role_user_user_id_foreign` (`user_id`);

--
-- Индексы таблицы `sources`
--
ALTER TABLE `sources`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `statuses`
--
ALTER TABLE `statuses`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `tasks`
--
ALTER TABLE `tasks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tasks_source_id_foreign` (`source_id`),
  ADD KEY `tasks_unit_id_foreign` (`unit_id`),
  ADD KEY `tasks_user_id_foreign` (`user_id`),
  ADD KEY `tasks_responsible_id_foreign` (`responsible_id`),
  ADD KEY `tasks_status_id_foreign` (`status_id`);

--
-- Индексы таблицы `task_comments`
--
ALTER TABLE `task_comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `task_comments_task_id_foreign` (`task_id`),
  ADD KEY `task_comments_status_id_foreign` (`status_id`),
  ADD KEY `task_comments_user_id_foreign` (`user_id`);

--
-- Индексы таблицы `task_status`
--
ALTER TABLE `task_status`
  ADD PRIMARY KEY (`id`),
  ADD KEY `task_status_task_id_foreign` (`task_id`),
  ADD KEY `task_status_status_id_foreign` (`status_id`);

--
-- Индексы таблицы `units`
--
ALTER TABLE `units`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `leads`
--
ALTER TABLE `leads`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT для таблицы `lead_comments`
--
ALTER TABLE `lead_comments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT для таблицы `lead_status`
--
ALTER TABLE `lead_status`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `menus`
--
ALTER TABLE `menus`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT для таблицы `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT для таблицы `oauth_clients`
--
ALTER TABLE `oauth_clients`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT для таблицы `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT для таблицы `permission_role`
--
ALTER TABLE `permission_role`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `role_user`
--
ALTER TABLE `role_user`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `sources`
--
ALTER TABLE `sources`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT для таблицы `statuses`
--
ALTER TABLE `statuses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `tasks`
--
ALTER TABLE `tasks`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT для таблицы `task_comments`
--
ALTER TABLE `task_comments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT для таблицы `task_status`
--
ALTER TABLE `task_status`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT для таблицы `units`
--
ALTER TABLE `units`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `leads`
--
ALTER TABLE `leads`
  ADD CONSTRAINT `leads_source_id_foreign` FOREIGN KEY (`source_id`) REFERENCES `sources` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `leads_status_id_foreign` FOREIGN KEY (`status_id`) REFERENCES `statuses` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `leads_unit_id_foreign` FOREIGN KEY (`unit_id`) REFERENCES `units` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `leads_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `lead_comments`
--
ALTER TABLE `lead_comments`
  ADD CONSTRAINT `lead_comments_lead_id_foreign` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`),
  ADD CONSTRAINT `lead_comments_status_id_foreign` FOREIGN KEY (`status_id`) REFERENCES `statuses` (`id`),
  ADD CONSTRAINT `lead_comments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Ограничения внешнего ключа таблицы `lead_status`
--
ALTER TABLE `lead_status`
  ADD CONSTRAINT `lead_status_lead_id_foreign` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`),
  ADD CONSTRAINT `lead_status_status_id_foreign` FOREIGN KEY (`status_id`) REFERENCES `statuses` (`id`);

--
-- Ограничения внешнего ключа таблицы `permission_menu`
--
ALTER TABLE `permission_menu`
  ADD CONSTRAINT `permission_menu_menu_id_foreign` FOREIGN KEY (`menu_id`) REFERENCES `menus` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `permission_menu_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `permission_role`
--
ALTER TABLE `permission_role`
  ADD CONSTRAINT `permission_role_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `permission_role_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `role_user`
--
ALTER TABLE `role_user`
  ADD CONSTRAINT `role_user_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `tasks`
--
ALTER TABLE `tasks`
  ADD CONSTRAINT `tasks_responsible_id_foreign` FOREIGN KEY (`responsible_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `tasks_source_id_foreign` FOREIGN KEY (`source_id`) REFERENCES `sources` (`id`),
  ADD CONSTRAINT `tasks_status_id_foreign` FOREIGN KEY (`status_id`) REFERENCES `statuses` (`id`),
  ADD CONSTRAINT `tasks_unit_id_foreign` FOREIGN KEY (`unit_id`) REFERENCES `units` (`id`),
  ADD CONSTRAINT `tasks_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Ограничения внешнего ключа таблицы `task_comments`
--
ALTER TABLE `task_comments`
  ADD CONSTRAINT `task_comments_status_id_foreign` FOREIGN KEY (`status_id`) REFERENCES `statuses` (`id`),
  ADD CONSTRAINT `task_comments_task_id_foreign` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`id`),
  ADD CONSTRAINT `task_comments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Ограничения внешнего ключа таблицы `task_status`
--
ALTER TABLE `task_status`
  ADD CONSTRAINT `task_status_status_id_foreign` FOREIGN KEY (`status_id`) REFERENCES `statuses` (`id`),
  ADD CONSTRAINT `task_status_task_id_foreign` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
