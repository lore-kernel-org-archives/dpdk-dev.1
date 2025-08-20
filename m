Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21FBECA0EED
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 Aug 2025 09:52:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7AF524065B;
	Wed, 20 Aug 2025 11:52:45 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 82E8E40292
 for <dev@dpdk.org>; Wed, 20 Aug 2025 11:52:44 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A2E7152B;
 Wed, 20 Aug 2025 02:52:35 -0700 (PDT)
Received: from [10.1.30.49] (JR4XG4HTQC-2.cambridge.arm.com [10.1.30.49])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D6453F63F;
 Wed, 20 Aug 2025 02:52:43 -0700 (PDT)
Message-ID: <6ffca6dc-09cb-448d-a34b-a93ee9bd854f@arm.com>
Date: Wed, 20 Aug 2025 10:52:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] dts: add missing type hints to method signatures
Content-Language: en-GB
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: dev@dpdk.org, dmarx@iol.unh.edu, probb@iol.unh.edu
References: <20250806162900.273571-1-abailey@iol.unh.edu>
 <20250818165054.447127-1-abailey@iol.unh.edu>
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <20250818165054.447127-1-abailey@iol.unh.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

Hi Andrew,

we are almost there! Just a few functional issues with the changes.

On 18/08/2025 17:50, Andrew Bailey wrote:
> diff --git a/dts/framework/remote_session/dpdk_shell.py b/dts/framework/remote_session/dpdk_shell.py
> index d4aa02f39b..18ce4e6011 100644
> --- a/dts/framework/remote_session/dpdk_shell.py
> +++ b/dts/framework/remote_session/dpdk_shell.py
> @@ -78,9 +78,14 @@ def __init__(
>       def path(self) -> PurePath:
>           """Relative path to the shell executable from the build folder."""
>   
> -    def _make_real_path(self):
> +    def _make_real_path(self) -> PurePath | str:
>           """Overrides :meth:`~.interactive_shell.InteractiveShell._make_real_path`.
>   
>           Adds the remote DPDK build directory to the path.
>           """
> -        return get_ctx().dpdk_build.remote_dpdk_build_dir.joinpath(self.path)
> +        real_path = get_ctx().dpdk_build.remote_dpdk_build_dir
> +        match real_path:
> +            case PurePath():
> +                return real_path.joinpath(self.path)
> +            case _:
> +                return ""

Rightfully, mypy is complaining about this, that is because this should 
only return PurePath. The implementation as written is also broken, 
because returning an empty string is not acceptable.

The problem here stems from the fact that remote_dpdk_build_dir can be 
str. In this case we wrap it in PurePath:

   return 
PurePath(get_ctx().dpdk_build.remote_dpdk_build_dir).joinpath(self.path)

But looking into remote_dpdk_build_dir it looks like that is only 
returning an empty str in case it's not present. In this case I would 
just change that property to return an empty PurePath instead:

   PurePath()

or change the whole signature to return None.

> diff --git a/dts/framework/remote_session/remote_session.py b/dts/framework/remote_session/remote_session.py
> index 89d4618c41..ba15b3baa3 100644
> --- a/dts/framework/remote_session/remote_session.py
> +++ b/dts/framework/remote_session/remote_session.py
> @@ -57,9 +57,7 @@ def __post_init__(self, init_stdout: str, init_stderr: str) -> None:
>       def __str__(self) -> str:
>           """Format the command outputs."""
>           return (
> -            f"stdout: '{self.stdout}'\n"
> -            f"stderr: '{self.stderr}'\n"
> -            f"return_code: '{self.return_code}'"
> +            f"stdout: '{self.stdout}'\nstderr: '{self.stderr}'\nreturn_code: '{self.return_code}'"
this was split across lines to reflect the actual output, i.e. for 
clarity. Why this change?

I noticed some other formatting changes as well like spacing in 
formatted strings. Changes which don't really pertain to this patch.
Do you have an IDE with a misconfigured formatter? If that's the case, 
please fix your settings to use ruff and the existing ruff format 
configuration.

>           )
>   
>   
> diff --git a/dts/framework/remote_session/testpmd_shell.py b/dts/framework/remote_session/testpmd_shell.py
> index ad8cb273dc..7b981111f6 100644
> --- a/dts/framework/remote_session/testpmd_shell.py
> +++ b/dts/framework/remote_session/testpmd_shell.py
> @@ -237,13 +237,17 @@ def find_action(
>   
>           return action
>   
> -    def error(self, message):
> +    def error(self, message) -> NoReturn:
>           """Augments :meth:`~argparse.ArgumentParser.error` with environment variable awareness."""
>           for action in self._actions:
>               if _is_from_env(action):
>                   action_name = _get_action_name(action)
>                   env_var_name = _get_env_var_name(action)
> -                env_var_value = os.environ.get(env_var_name)
> +                match env_var_name:
> +                    case None:
> +                        env_var_value = None
> +                    case nonEmpty:
> +                        env_var_value = os.environ.get(nonEmpty)
This is a bit too verbose for something as simple as an if. But this is 
not a reasonable solution in this case.

Because of `if _is_from_env(action)` then `env_var_name` cannot be None. 
The only case in which this could be None is a bug. This is the case 
where an assertion should go in instead:

     assert env_var_name is not None, "Action was set from environment, 
but no environment variable name was found."

>   
>                   message = message.replace(
>                       f"argument {action_name}",
> diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py
> index 4355aeeb4b..4db7de2487 100644
> --- a/dts/framework/test_run.py
> +++ b/dts/framework/test_run.py
> @@ -162,7 +162,7 @@ class TestRun:
>       config: TestRunConfiguration
>       logger: DTSLogger
>   
> -    state: "State"
> +    state: "State" | None
the docs builder doesn't like using the piping operator with a string 
annotation. I am surprised the CI didn't complain here. To avoid this 
issue you should use Union from typing instead:

   Union["State", None]

>       ctx: Context
>       result: TestRunResult
>       selected_tests: list[TestScenario]
> @@ -235,7 +235,7 @@ def spin(self):
>                   self.state.before()
>                   next_state = self.state.next()
>               except (KeyboardInterrupt, Exception) as e:
> -                next_state = self.state.handle_exception(e)
> +                next_state = self.state.handle_exception(Exception(e))
This is a breaking change. All of the underlying exception checks will 
no longer work if you wrap a custom exception with a generic exception.

The correct solution is to let the signature of handle_exception accept 
BaseException instead which will also cover KeyboardInterrupt.

>               finally:
>                   self.state.after()
>               if next_state is not None:
Thank you,
Luca
