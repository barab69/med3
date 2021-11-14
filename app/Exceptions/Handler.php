<?php

namespace App\Exceptions;


use App\Services\Response\ResponseServise;
use Illuminate\Auth\AuthenticationException;
use Illuminate\Foundation\Exceptions\Handler as ExceptionHandler;
use Symfony\Component\HttpKernel\Exception\AccessDeniedHttpException;

class Handler extends ExceptionHandler
{
    /**
     * A list of the exception types that are not reported.
     *
     * @var array
     */
    protected $dontReport = [
        //
    ];

    /**
     * A list of the inputs that are never flashed for validation exceptions.
     *
     * @var array
     */
    protected $dontFlash = [
        'password',
        'password_confirmation',
    ];

    /**
     * Register the exception handling callbacks for the application.
     *
     * @return void
     */
    public function register()
    {

        $this->renderable(function (AccessDeniedHttpException $e, $request) {
            if($request->wantsJson()) {
                return ResponseServise::notFound();
            }
        });

        $this->renderable(function (AuthenticationException $e, $request) {
            if($request->wantsJson()) {
                return ResponseServise::notAuthorize();
            }
        });


    }
}
