Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901A9D2ECF7
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 09:13:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 62AD040156;
	Tue, 20 Jan 2026 10:13:25 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 3D9EE4013F
 for <dev@dpdk.org>; Tue, 20 Jan 2026 10:13:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768900403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HonfrJgSJRwJ5BM2kvcTc+ZeXnbfg6ZTBkFvsqQksik=;
 b=NSCZ5upfCHH02vCPa9RIc9b5q90fkCNLjRX0HD6tIhsAQAheL1iPPM0KDKbc0zz38FXUff
 +ryN2uQAU9JdvwUlKeJ08Q6BRzIUOCzcMlg96n73MxFHWSADaclKz0ga+4hhOoR9OYJBnU
 rDJIMKw5c4zYyhFYHwZpP/rbf2QB+a4=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-QMOxWTuBNxGAZRaN7_teHA-1; Tue, 20 Jan 2026 04:13:20 -0500
X-MC-Unique: QMOxWTuBNxGAZRaN7_teHA-1
X-Mimecast-MFC-AGG-ID: QMOxWTuBNxGAZRaN7_teHA_1768900399
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-59b796a0d0aso3402230e87.3
 for <dev@dpdk.org>; Tue, 20 Jan 2026 01:13:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768900398; x=1769505198;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HonfrJgSJRwJ5BM2kvcTc+ZeXnbfg6ZTBkFvsqQksik=;
 b=lATZK+sykDtblBtTLw4B3GlzzZ/0utVJb4bzvVU4SAQr79Uod5iYHpXXi/5ZIx1to9
 ocStsAEdWiRU/757CbZ7q0rUOJ+8cXOBXKPfssdPmcUkmj2DGWGA+DiOVJt15TT1dkLo
 f5njkotoeT3APjV0g0dN5xxpABdwfl/omm4gfQXGNkQcYfkctMEPxAbqkbFa0P4ju+mU
 j5iWThQte7ud3eQ4UDhsgbCRXez3jKWJUCRM1ePY/O8mSeXGvm5QegboCmuUUIboMcUj
 KzCe9YGmtfvb6y7Rhpz2Mdw8X37rAhMnHdjSTwT+H+ooWSPZNHAfWbfW8riNJhQ4nSHL
 vi+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXU2fVqIGFFaGgKK8W7QfnDq1rh2dDqxmFi2qsfL13RsskLhza8MQjGY0sm0pELaNcI5o8=@dpdk.org
X-Gm-Message-State: AOJu0YwVoNy12ZnV+BMvdyLE8caxD9ttERlFmr7tsqrLRWWnY/GIa5Ts
 37MEtpr/SmVKY2uwCwKCVLQH9lLZUTdLdp82vp1e5XSsY/tdedudttzA4+5DbAT0h2MFcAYn3gH
 vf0JqG5F9960n9zT8zbEdVsPAy9iSxtCAZnf5cRZqInqwhkHYoSsKTzyGL14WhOo32fnj7hldKQ
 fCzYLsSulgPUq8hhiQEfs=
X-Gm-Gg: AZuq6aKHzOoEn5y1sxvAKrm5sjucVERTCUCbbJ+MRptyhR0V7L/GWOSVNR5B9v9sLUC
 sYiIMe8IekEm6DDF5LdQwP3WAxz6vgsh9hiWbxRdni9nWd10wYwsuAAyHjm2EtgJVi8ExoHa8g6
 RbmBgjF9S+WotxlRh2RdQ5EF/xzfn71W/P1hk57vJaLoREWOY19AYHLv3F+BhnDiAPkO3z
X-Received: by 2002:a05:6512:12c9:b0:595:7fa2:acd with SMTP id
 2adb3069b0e04-59dc8f2889emr542564e87.21.1768900398548; 
 Tue, 20 Jan 2026 01:13:18 -0800 (PST)
X-Received: by 2002:a05:6512:12c9:b0:595:7fa2:acd with SMTP id
 2adb3069b0e04-59dc8f2889emr542552e87.21.1768900398056; Tue, 20 Jan 2026
 01:13:18 -0800 (PST)
MIME-Version: 1.0
References: <20251024185056.607160-3-dmarx@iol.unh.edu>
 <20251107215020.255182-1-dmarx@iol.unh.edu>
In-Reply-To: <20251107215020.255182-1-dmarx@iol.unh.edu>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 20 Jan 2026 10:13:06 +0100
X-Gm-Features: AZwV_QiutDhek1G-6AsZHCECPGXxGZBY44n5Rkev98kqs_1_CF4TvkbnrAlMr5g
Message-ID: <CAJFAV8x4g4yy3LO7bfKh-UzFZ=fA5Y0Q3hAvOamw2o4rFMbeKA@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] dts: add start Tx first method to testpmd shell
To: Dean Marx <dmarx@iol.unh.edu>, probb@iol.unh.edu, luca.vizzarro@arm.com
Cc: yoan.picchi@foss.arm.com, Honnappa.Nagarahalli@arm.com, 
 paul.szczepanek@arm.com, dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yHTkBjEuJ-Jst_9u3wVH8VOJHarjQv-SQJMGLTtCBYg_1768900399
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

Hello dts guys,

On Fri, 7 Nov 2025 at 22:50, Dean Marx <dmarx@iol.unh.edu> wrote:
>
> Add start tx_first method to testpmd shell, which sends
> a specified number of burst packets prior to starting
> packet forwarding.
>
> Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
> Reviewed-by: Luca Vizzarro <luca.vizzarro@arm.com>
> ---
>  dts/api/testpmd/__init__.py | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/dts/api/testpmd/__init__.py b/dts/api/testpmd/__init__.py
> index aadb7f4e70..6d70927660 100644
> --- a/dts/api/testpmd/__init__.py
> +++ b/dts/api/testpmd/__init__.py
> @@ -204,6 +204,27 @@ def start(self, verify: bool = True) -> None:
>                  self._logger.debug(f"Failed to start packet forwarding: \n{start_cmd_output}")
>                  raise InteractiveCommandExecutionError("Testpmd failed to start packet forwarding.")
>
> +    @_requires_started_ports
> +    def start_tx_first(self, burst_num: int, verify: bool = True) -> None:
> +        """Start packet forwarding after sending specified number of bursts of packets.
> +
> +        Args:
> +            burst_num: Number of packets to send before stopping transmission.
> +            verify: If :data:`True` , a second start command will be sent in an attempt to verify
> +                packet forwarding started as expected.
> +
> +        Raises:
> +            InteractiveCommandExecutionError: If `verify` is :data:`True` and forwarding fails to
> +                start or ports fail to come up.
> +        """
> +        self.send_command(f"start tx_first {burst_num if burst_num is not None else ""}")
> +        if verify:
> +            # If forwarding was already started, sending "start" again should tell us
> +            start_cmd_output = self.send_command("start")
> +            if "Packet forwarding already started" not in start_cmd_output:
> +                self._logger.debug(f"Failed to start packet forwarding: \n{start_cmd_output}")
> +                raise InteractiveCommandExecutionError("Testpmd failed to start packet forwarding.")
> +
>      def stop(self, verify: bool = True) -> str:
>          """Stop packet forwarding.
>

I can see (uncaught) warnings in GHA when generating the documentation.
I don't know if this is something new, or if it was like this from the start.

Please have a look.

2026-01-20T08:16:58.5130393Z [250/252] Generating dts_api_html with a
custom command
2026-01-20T08:16:58.5131324Z WARNING: autodoc: failed to import module
'testpmd' from module 'api'; the following exception was raised:
2026-01-20T08:16:58.5132132Z Traceback (most recent call last):
2026-01-20T08:16:58.5132676Z   File
"/usr/lib/python3/dist-packages/sphinx/ext/autodoc/importer.py", line
70, in import_module
2026-01-20T08:16:58.5133175Z     return importlib.import_module(modname)
2026-01-20T08:16:58.5133807Z   File
"/usr/lib/python3.10/importlib/__init__.py", line 126, in
import_module
2026-01-20T08:16:58.5134351Z     return
_bootstrap._gcd_import(name[level:], package, level)
2026-01-20T08:16:58.5134771Z   File "<frozen importlib._bootstrap>",
line 1050, in _gcd_import
2026-01-20T08:16:58.5135202Z   File "<frozen importlib._bootstrap>",
line 1027, in _find_and_load
2026-01-20T08:16:58.5135997Z   File "<frozen importlib._bootstrap>",
line 1006, in _find_and_load_unlocked
2026-01-20T08:16:58.5136465Z   File "<frozen importlib._bootstrap>",
line 688, in _load_unlocked
2026-01-20T08:16:58.5136900Z   File "<frozen
importlib._bootstrap_external>", line 879, in exec_module
2026-01-20T08:16:58.5137348Z   File "<frozen
importlib._bootstrap_external>", line 1017, in get_code
2026-01-20T08:16:58.5137795Z   File "<frozen
importlib._bootstrap_external>", line 947, in source_to_code
2026-01-20T08:16:58.5138259Z   File "<frozen importlib._bootstrap>",
line 241, in _call_with_frames_removed
2026-01-20T08:16:58.5138733Z   File
"/home/runner/work/dpdk/dpdk/dts/api/testpmd/__init__.py", line 230
2026-01-20T08:16:58.5139388Z     self.send_command(f"start tx_first
{burst_num if burst_num is not None else ""}")
2026-01-20T08:16:58.5139819Z
                                          ^
2026-01-20T08:16:58.5140133Z SyntaxError: f-string: expecting '}'
2026-01-20T08:16:58.5140317Z

...

https://github.com/DPDK/dpdk/actions/runs/21163780224/job/60863594703#step:19:9587



-- 
David Marchand

