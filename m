Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F53CA0FED
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 Aug 2025 15:46:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 95A2C4029E;
	Wed, 27 Aug 2025 17:46:28 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id DEB6740292
 for <dev@dpdk.org>; Wed, 27 Aug 2025 17:46:26 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC97F1688;
 Wed, 27 Aug 2025 08:46:17 -0700 (PDT)
Received: from JR4XG4HTQC (unknown [10.1.194.29])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D31903F694;
 Wed, 27 Aug 2025 08:46:24 -0700 (PDT)
Date: Wed, 27 Aug 2025 16:46:20 +0100
From: Luca Vizzarro <luca.vizzarro@arm.com>
To: Dean Marx <dmarx@iol.unh.edu>
Cc: probb@iol.unh.edu, yoan.picchi@foss.arm.com, 
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com, dev@dpdk.org
Subject: Re: [PATCH v2] dts: add test case docstring checks to format script
Message-ID: <6zyctvaihjdlgn3es3z2s3d3ae6ifc33vcqcobhylvz26m7ney@4nzef5s5lxnw>
References: <20250820193815.61078-1-dmarx@iol.unh.edu>
 <20250826200720.104443-1-dmarx@iol.unh.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826200720.104443-1-dmarx@iol.unh.edu>
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

Hi Dean,

thank you for your patch! Looks mostly good, a couple of comments
though.

On Tue, Aug 26, 2025 at 04:07:20PM +0000, Dean Marx wrote:
> diff --git a/devtools/dts-check-docstrings.py b/devtools/dts-check-docstrings.py
> new file mode 100755
> index 0000000000..0baee6e383
> --- /dev/null
> +++ b/devtools/dts-check-docstrings.py
> @@ -0,0 +1,52 @@

Consider adding a shebang here, like it's already done with the other
scripts.

> +# SPDX-License-Identifier: BSD-3-Clause
> +# Copyright(c) 2025 University of New Hampshire
> +
> +import sys
> +from ast import FunctionDef, Name, walk, get_docstring, parse
> +from pathlib import Path
> +
> +BASE_DIR = Path(__file__).resolve().parent  # dpdk/

The hint is actually wrong, this is dpdk/devtools. I think you meant to
make this:

    BASE_DIR = Path(__file__).resolve().parent.parent

> +TESTS_DIR = BASE_DIR.parent / "dts" / "tests"  # dts/tests/

and this would just be:

    TESTS_DIR = BASE_DIR / "dts" / "tests"

> +
> +
> +def has_test_decorator(node: FunctionDef) -> bool:
> +    """Return True if function has @func_test or @perf_test decorator."""
> +    for decorator in node.decorator_list:
> +        if isinstance(decorator, Name) and decorator.id in {"func_test", "perf_test"}:

I wouldn't hard code the decorator names like this. Put this in a
constant at the top instead:

    DECORATOR_NAMES = {"func_test", "perf_test"}

> +            return True
> +    return False
<snip>
> diff --git a/devtools/dts-check-format.sh b/devtools/dts-check-format.sh
> index 907eed1293..da6e6f34ee 100755
> --- a/devtools/dts-check-format.sh
> +++ b/devtools/dts-check-format.sh
> @@ -86,7 +86,14 @@ if $lint; then
>  		ruff check --fix
>  		errors=$((errors + $?))
>  
> +		docstring_script_path=$(dirname "$0")
> +		docstring_script_path=$(cd "$docstring_script_path" && pwd)
> +		docstring_script="$docstring_script_path/dts-check-docstrings.py"
> +		python "$docstring_script"
> +		errors=$((errors + $?))
> +

I wouldn't insert this with the ruff if scope. This can still stay under
the lint if block, but give it its own.

>  		git update-index --refresh
> +

Best regards,
Luca
