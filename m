Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C092FD2ECF7
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 09:17:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B2B0540DCB;
	Tue, 20 Jan 2026 10:17:15 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 86DC94013F
 for <dev@dpdk.org>; Tue, 20 Jan 2026 10:17:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768900633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zg9n5mdjMsZBXfp3skWVh+hBMXgn4CBavsNgS05trO0=;
 b=B5B7Qbl1IH2WqL+bw3QY0c2L7PtiKFwBs6+FD6UhUsMV+8ByXgHS8ZMp51coJOSVE5KaEg
 +SiuHw23dX0iVCIRlRK9vKrXR/UnJNteM5d8qylFkvqyYAU2JqsO2INXGc8JTlmllwvdYF
 9UX71ajqK2irQFgvlZVN/EZBCIFuneU=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-Pr1DbkakOgK-EhLKt4JXbQ-1; Tue, 20 Jan 2026 04:17:11 -0500
X-MC-Unique: Pr1DbkakOgK-EhLKt4JXbQ-1
X-Mimecast-MFC-AGG-ID: Pr1DbkakOgK-EhLKt4JXbQ_1768900630
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-59b6a97e566so3850879e87.1
 for <dev@dpdk.org>; Tue, 20 Jan 2026 01:17:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768900630; x=1769505430;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zg9n5mdjMsZBXfp3skWVh+hBMXgn4CBavsNgS05trO0=;
 b=snG7uOThNWPJmpi6MknlcqgQ1fxaaIDsPjh0+MAvke1l27RvKyFEG4/ezmdpZQeKAH
 7fOst5NBKWx8uJoeXRVjjW9WAu2iI6WLNWOe+TfudC+GdyIidXeUVX3k49VXU9Mh7qQK
 VyiKvlslulZfE1Jzuvp6quEk6QeDwh8f6k+FFIBkz3tadcI/HcLfKqpfAU3dEWwDWCRg
 omAwHz7tGMwiV3s+c59VjNHidVfD89VZKr/84hKIAX0u/mYPHaqmRI/awp3i5dTq3+pB
 StOckyKosVJd3jZL1MUKHwFJLzSYJH1ZEsAQKcPWPNVKZBoC02xdxc2xR2KSXkxgyLSE
 zLfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYKf4wVskpOHvHjutNud2WtR1dKCy+d1qIqPoWHrAanrWArnBil1N02mEBfRVvwK0HMVo=@dpdk.org
X-Gm-Message-State: AOJu0YxJn+Q8Xp8Jg4CIlaRpavRFJ1cXEXM8k8oTTLeq7A7pJq3wmiXi
 Hq6aKc9YDQrKf5B59T8KoJ2nJZOcHmu4ipM8fS6TiYVoAXDAo9o9arqIC/gLr0deThOCK3eQuJf
 EXRztIadICBAhLb16ja+Zu+vYT+HS5LVtv9S+VxZeUM3sJw1a8dMO0BbFRUhaZX0L//qyq4afOQ
 3PKr7GVqTnuH8KgtbvEZo=
X-Gm-Gg: AZuq6aLVoBV4IEuKkDPnjFJQuD5ApV/IXwaz/q4P4RgX6ezfKNjztd03Cxf+vlHrVp8
 9ky0/4Pi7tW3UieendsNMM8oKCXWyZxO3G3WEp4xysDnMjcnhdfcTRpp80oBVatoMhruS43IMOD
 TT1GPXlfLluoNUim7SKmWQlZJccQKGGLOAg+nQg8pclv3KsoZkXOyr3WAzTfyDbhg4/M10
X-Received: by 2002:a05:6512:128a:b0:595:7854:af77 with SMTP id
 2adb3069b0e04-59bafebe300mr4060576e87.22.1768900629857; 
 Tue, 20 Jan 2026 01:17:09 -0800 (PST)
X-Received: by 2002:a05:6512:128a:b0:595:7854:af77 with SMTP id
 2adb3069b0e04-59bafebe300mr4060558e87.22.1768900629389; Tue, 20 Jan 2026
 01:17:09 -0800 (PST)
MIME-Version: 1.0
References: <20251024185056.607160-3-dmarx@iol.unh.edu>
 <20251107215020.255182-1-dmarx@iol.unh.edu>
 <CAJFAV8x4g4yy3LO7bfKh-UzFZ=fA5Y0Q3hAvOamw2o4rFMbeKA@mail.gmail.com>
In-Reply-To: <CAJFAV8x4g4yy3LO7bfKh-UzFZ=fA5Y0Q3hAvOamw2o4rFMbeKA@mail.gmail.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 20 Jan 2026 10:16:57 +0100
X-Gm-Features: AZwV_Qgj_U99iObHjWeuUCaTDp4Zbh4BeDQrMDCIeSfly5gRQQIgtTqa9AYL8KQ
Message-ID: <CAJFAV8w0kGw4Dxjr1xhuvhbcEK4WAw-G6Yy9iBQ1d5sKkQm-Qg@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] dts: add start Tx first method to testpmd shell
To: Dean Marx <dmarx@iol.unh.edu>, probb@iol.unh.edu, luca.vizzarro@arm.com
Cc: yoan.picchi@foss.arm.com, Honnappa.Nagarahalli@arm.com, 
 paul.szczepanek@arm.com, dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, 
 sismis@dyna-nic.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lA8aJWigVvVgtHKJZ80xcdrFyk-jhs5ghdGIACSC1UA_1768900630
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

On Tue, 20 Jan 2026 at 10:13, David Marchand <david.marchand@redhat.com> wrote:
>
> Hello dts guys,
>
> On Fri, 7 Nov 2025 at 22:50, Dean Marx <dmarx@iol.unh.edu> wrote:
> >
> > Add start tx_first method to testpmd shell, which sends
> > a specified number of burst packets prior to starting
> > packet forwarding.
> >
> > Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
> > Reviewed-by: Luca Vizzarro <luca.vizzarro@arm.com>
> > ---
> >  dts/api/testpmd/__init__.py | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >
> > diff --git a/dts/api/testpmd/__init__.py b/dts/api/testpmd/__init__.py
> > index aadb7f4e70..6d70927660 100644
> > --- a/dts/api/testpmd/__init__.py
> > +++ b/dts/api/testpmd/__init__.py
> > @@ -204,6 +204,27 @@ def start(self, verify: bool = True) -> None:
> >                  self._logger.debug(f"Failed to start packet forwarding: \n{start_cmd_output}")
> >                  raise InteractiveCommandExecutionError("Testpmd failed to start packet forwarding.")
> >
> > +    @_requires_started_ports
> > +    def start_tx_first(self, burst_num: int, verify: bool = True) -> None:
> > +        """Start packet forwarding after sending specified number of bursts of packets.
> > +
> > +        Args:
> > +            burst_num: Number of packets to send before stopping transmission.
> > +            verify: If :data:`True` , a second start command will be sent in an attempt to verify
> > +                packet forwarding started as expected.
> > +
> > +        Raises:
> > +            InteractiveCommandExecutionError: If `verify` is :data:`True` and forwarding fails to
> > +                start or ports fail to come up.
> > +        """
> > +        self.send_command(f"start tx_first {burst_num if burst_num is not None else ""}")
> > +        if verify:
> > +            # If forwarding was already started, sending "start" again should tell us
> > +            start_cmd_output = self.send_command("start")
> > +            if "Packet forwarding already started" not in start_cmd_output:
> > +                self._logger.debug(f"Failed to start packet forwarding: \n{start_cmd_output}")
> > +                raise InteractiveCommandExecutionError("Testpmd failed to start packet forwarding.")
> > +
> >      def stop(self, verify: bool = True) -> str:
> >          """Stop packet forwarding.
> >
>
> I can see (uncaught) warnings in GHA when generating the documentation.
> I don't know if this is something new, or if it was like this from the start.
>
> Please have a look.
>
> 2026-01-20T08:16:58.5130393Z [250/252] Generating dts_api_html with a
> custom command
> 2026-01-20T08:16:58.5131324Z WARNING: autodoc: failed to import module
> 'testpmd' from module 'api'; the following exception was raised:
> 2026-01-20T08:16:58.5132132Z Traceback (most recent call last):
> 2026-01-20T08:16:58.5132676Z   File
> "/usr/lib/python3/dist-packages/sphinx/ext/autodoc/importer.py", line
> 70, in import_module
> 2026-01-20T08:16:58.5133175Z     return importlib.import_module(modname)
> 2026-01-20T08:16:58.5133807Z   File
> "/usr/lib/python3.10/importlib/__init__.py", line 126, in
> import_module
> 2026-01-20T08:16:58.5134351Z     return
> _bootstrap._gcd_import(name[level:], package, level)
> 2026-01-20T08:16:58.5134771Z   File "<frozen importlib._bootstrap>",
> line 1050, in _gcd_import
> 2026-01-20T08:16:58.5135202Z   File "<frozen importlib._bootstrap>",
> line 1027, in _find_and_load
> 2026-01-20T08:16:58.5135997Z   File "<frozen importlib._bootstrap>",
> line 1006, in _find_and_load_unlocked
> 2026-01-20T08:16:58.5136465Z   File "<frozen importlib._bootstrap>",
> line 688, in _load_unlocked
> 2026-01-20T08:16:58.5136900Z   File "<frozen
> importlib._bootstrap_external>", line 879, in exec_module
> 2026-01-20T08:16:58.5137348Z   File "<frozen
> importlib._bootstrap_external>", line 1017, in get_code
> 2026-01-20T08:16:58.5137795Z   File "<frozen
> importlib._bootstrap_external>", line 947, in source_to_code
> 2026-01-20T08:16:58.5138259Z   File "<frozen importlib._bootstrap>",
> line 241, in _call_with_frames_removed
> 2026-01-20T08:16:58.5138733Z   File
> "/home/runner/work/dpdk/dpdk/dts/api/testpmd/__init__.py", line 230
> 2026-01-20T08:16:58.5139388Z     self.send_command(f"start tx_first
> {burst_num if burst_num is not None else ""}")
> 2026-01-20T08:16:58.5139819Z
>                                           ^
> 2026-01-20T08:16:58.5140133Z SyntaxError: f-string: expecting '}'
> 2026-01-20T08:16:58.5140317Z
>
> ...
>
> https://github.com/DPDK/dpdk/actions/runs/21163780224/job/60863594703#step:19:9587

Ah, it seems Lukas has a fix.
https://patchwork.dpdk.org/project/dpdk/patch/366f384e90cce0867652231494d8c873066b5fe6.1768518003.git.sismis@dyna-nic.com/

Can this series be reviewed?


Thanks.

-- 
David Marchand

