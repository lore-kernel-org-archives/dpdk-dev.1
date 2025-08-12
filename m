Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE484CA0EC4
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 Aug 2025 03:17:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DE12E40270;
	Tue, 12 Aug 2025 05:17:17 +0200 (CEST)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mails.dpdk.org (Postfix) with ESMTP id E3A694026C
 for <dev@dpdk.org>; Tue, 12 Aug 2025 05:17:15 +0200 (CEST)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2405c0c431cso46971855ad.1
 for <dev@dpdk.org>; Mon, 11 Aug 2025 20:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1754968635; x=1755573435; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NooYKB6+MVIZbRwzY7amQtZtQP9vUI9A10OY+4C1fzA=;
 b=SjJceVCHwa2PqOwRgasYrTXSJ3trrYEEVPiu5G7x/odaGnvRjaykXil5/r2MAthKus
 OxaXICUbr33JwkwAnzqNu0Mzoxo1JKM1RWwNoS3zdCx71AAcbsJRwVZMAtaOEezE1sq5
 kSImPm93KArPJGfN+HSd7OZkfFvSIhl/yxsjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754968635; x=1755573435;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NooYKB6+MVIZbRwzY7amQtZtQP9vUI9A10OY+4C1fzA=;
 b=Crjgek6uQBwro4Ecefz+yjKj/e51D0OgjqDA6HfGPKPN01FdefBtOQLOIRL9P1RLlM
 0hrrezYwa/KenqacngzykhN5TEk8UPIPPxEjZQbTU1Owp6oQEiC7j3R2pqiPfdy7vOg3
 zhKm22SWO98MUSHwN3tI+trumVe5m1SHMg5J+zlrTMepHvkujD0xWdcu234jaW+FFpjE
 LWs5aAfEo2/e+Fl6k2JmcTRpHqMgVqstT8latjyViU6fmTorGccIrlyfjeaZfQkn1ui8
 hNnXP4/1uM1WyYn6CkK9wQWRE2ySF9i+STTKZ0f/joh9l2+jO/s06Mqzkz/zpq/vQGrT
 hS9Q==
X-Gm-Message-State: AOJu0YzHim9YBe3DwfP881pClWoFWej3Or329p46S4jAneeNER1PkGyw
 bX01xtZre5oKHVYiMtOm8xjqrH92PveTIMO7aW7G0TKV+cuRgXDJQ7jtH5ZPVj1mP9Yok/Rp61h
 XI1OX881KCyXHwzu/H5fo4/nEIB2Km8/N9dyWMFDj9eUyaqbZMOPDrlM=
X-Gm-Gg: ASbGncut9/XaWxn7U2sf7766ZpDOQ5IOGJsTjjxrqNPbSWKqThuHP++kGIe5N0Xwj6S
 RBmb4nwkdj82YcfRKtL7IkuYbbpPOqI2t/+LCWu02a4nBuUN8kUzKlKfL84CRCeDw408McPaIT/
 Jk4W21UH1ETtd2wRNvmHpzKECtcILawP+bhu8ebnU+KewPEU3EoKzQ5/2iU9ulUrBO+cKgn2zed
 SmBAgPa/WD8nuBYjn876qfdomeMcoSHog==
X-Google-Smtp-Source: AGHT+IEFV62gpqd/DAYEL4+vFqi/6Kaptl69BirGfX/XKMs+EUZBbLF8t7C4kxWiC+R5h+2BySChcQV/BAjbP3vfyIQ=
X-Received: by 2002:a17:902:7681:b0:240:bf59:26bb with SMTP id
 d9443c01a7336-242fc242d8dmr18668635ad.19.1754968634936; Mon, 11 Aug 2025
 20:17:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250725151503.87374-1-luca.vizzarro@arm.com>
 <20250725151503.87374-6-luca.vizzarro@arm.com>
In-Reply-To: <20250725151503.87374-6-luca.vizzarro@arm.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Mon, 11 Aug 2025 23:10:54 -0400
X-Gm-Features: Ac12FXz5a2aVwfT77Fo4xjXfXPa87BMpNHkCgTaP3KCGci-CSVRcVS3aZQ_o-tk
Message-ID: <CAJvnSUD0q-ZS1hhn-CRzcza92YhYwhD00CyShW5TNS27k2LYrw@mail.gmail.com>
Subject: Re: [PATCH 5/6] dts: make log files into artifacts
To: Luca Vizzarro <luca.vizzarro@arm.com>
Cc: dev@dpdk.org, Paul Szczepanek <paul.szczepanek@arm.com>
Content-Type: multipart/alternative; boundary="00000000000013ea3d063c227a5f"
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

--00000000000013ea3d063c227a5f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 11:15=E2=80=AFAM Luca Vizzarro <luca.vizzarro@arm.c=
om>
wrote:

> Make log files behave like artifacts as dictated by the Artifact class.
> Implicitly, this will automatically place all the logs in a structured
> manner.
>
> Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>
> Reviewed-by: Paul Szczepanek <paul.szczepanek@arm.com>
> ---
>
> -    def set_stage(self, stage: str, log_file_path: Path | None =3D None)=
 ->
> None:
> -        """Set the DTS execution stage and optionally log to files.
> +    def set_stage(self, stage: str, log_file_name: str | None =3D None) =
->
> None:
> +        """Set the DTS execution stage and optionally log to artifact
> files.
>
>          Set the DTS execution stage of the DTSLog class and optionally a=
dd
> -        file handlers to the instance if the log file name is provided.
> +        artifact handlers to the instance if the log artifact file name
> is provided.
>
> -        The file handlers log all messages. One is a regular
> human-readable log file and
> -        the other one is a machine-readable log file with extra debug
> information.
> +        The artifact handlers log all messages. One is a regular
> human-readable log artifact and
> +        the other one is a machine-readable log artifact with extra debu=
g
> information.
>
>          Args:
>              stage: The DTS stage to set.
> -            log_file_path: An optional path of the log file to use. This
> should be a full path
> -                (either relative or absolute) without suffix (which will
> be appended).
> +            log_file_name: An optional name of the log artifact file to
> use. This should be without
> +                suffix (which will be appended).
>          """
> -        self._remove_extra_file_handlers()
> +        self._remove_extra_artifact_handlers()
>
>          if DTSLogger._stage !=3D stage:
>              self.info(f"Moving from stage '{DTSLogger._stage}' to stage
> '{stage}'.")
>              DTSLogger._stage =3D stage
>
> -        if log_file_path:
> -
> self._extra_file_handlers.extend(self._add_file_handlers(log_file_path))
> +        if log_file_name:
> +
> self._extra_artifact_handlers.extend(self._add_artifact_handlers(log_file=
_name))
>

I have run from this patch and although the new tree structure is a welcome
addition for organizing (assuming we want to maintain testcase log files),
I think there are some issues or ideas I would like to raise:

1. Most importantly, I notice that the testsuite and testcase files are no
longer tracking testsuite information - they're basically empty except for
transition information. I wonder if their respective artifact handlers are
being popped prematurely with the set_stage() function above? I am out of
time but that seems the most likely source of this issue. Or, their
handlers are being misconfigured in _add_artifact_handlers() but I don't
think so. I can DM you an output dir from dts for-main and also from my
branch with your series applied.
2. I see the testsuite log file is being written to the testsuite dir and
the testcase dir. I don't feel super strongly about this but in my opinion
the more intuitive way to present the logs would be without writing 1 file
to two locations.
3. Another open question... is it better to provide this current level of
granularity (testcase logs), or better to just provide the top level log
file and the testsuite logs? My initial impression is that with the tree
structure, the high number of log files is basically harmless, and would
provide a quick path to finding the specific logs one wants (when they know
the failing testcase) so I'm not requesting a change... just raising the
point for discussion.

>
> 2.43.0
>
>
Reviewed-by: Patrick Robb <probb@iol.unh.edu>
Tested-by: Patrick Robb <probb@iol.unh.edu>

--00000000000013ea3d063c227a5f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jul 25,=
 2025 at 11:15=E2=80=AFAM Luca Vizzarro &lt;<a href=3D"mailto:luca.vizzarro=
@arm.com">luca.vizzarro@arm.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">Make log files behave like artifacts as di=
ctated by the Artifact class.<br>
Implicitly, this will automatically place all the logs in a structured<br>
manner.<br>
<br>
Signed-off-by: Luca Vizzarro &lt;<a href=3D"mailto:luca.vizzarro@arm.com" t=
arget=3D"_blank">luca.vizzarro@arm.com</a>&gt;<br>
Reviewed-by: Paul Szczepanek &lt;<a href=3D"mailto:paul.szczepanek@arm.com"=
 target=3D"_blank">paul.szczepanek@arm.com</a>&gt;<br>
---<br><br>
-=C2=A0 =C2=A0 def set_stage(self, stage: str, log_file_path: Path | None =
=3D None) -&gt; None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Set the DTS execution stage =
and optionally log to files.<br>
+=C2=A0 =C2=A0 def set_stage(self, stage: str, log_file_name: str | None =
=3D None) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Set the DTS execution stage =
and optionally log to artifact files.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Set the DTS execution stage of the DTSLog=
 class and optionally add<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 file handlers to the instance if the log file =
name is provided.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 artifact handlers to the instance if the log a=
rtifact file name is provided.<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 The file handlers log all messages. One is a r=
egular human-readable log file and<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 the other one is a machine-readable log file w=
ith extra debug information.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 The artifact handlers log all messages. One is=
 a regular human-readable log artifact and<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 the other one is a machine-readable log artifa=
ct with extra debug information.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Args:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stage: The DTS stage to set=
.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 log_file_path: An optional path =
of the log file to use. This should be a full path<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (either relative o=
r absolute) without suffix (which will be appended).<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 log_file_name: An optional name =
of the log artifact file to use. This should be without<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 suffix (which will=
 be appended).<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._remove_extra_file_handlers()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._remove_extra_artifact_handlers()<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if DTSLogger._stage !=3D stage:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"http://self.info=
" rel=3D"noreferrer" target=3D"_blank">self.info</a>(f&quot;Moving from sta=
ge &#39;{DTSLogger._stage}&#39; to stage &#39;{stage}&#39;.&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DTSLogger._stage =3D stage<=
br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if log_file_path:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._extra_file_handlers.extend=
(self._add_file_handlers(log_file_path))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if log_file_name:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._extra_artifact_handlers.ex=
tend(self._add_artifact_handlers(log_file_name))<br></blockquote><div><br><=
/div><div>I have run from this patch and although the new tree structure is=
 a welcome addition for organizing (assuming we want to maintain testcase l=
og files), I think there are some issues or ideas I would like to raise:</d=
iv><div><br></div><div>1. Most importantly, I notice that the testsuite and=
 testcase files are no longer tracking testsuite information - they&#39;re =
basically empty except for transition information. I wonder if their respec=
tive artifact handlers are being popped prematurely with the set_stage() fu=
nction above? I am out of time but that seems the most likely source of thi=
s issue. Or, their handlers are being misconfigured in _add_artifact_handle=
rs() but I don&#39;t think so. I can DM you an output dir from dts for-main=
 and also from my branch with your series applied.</div><div>2. I see the t=
estsuite log file is being written to the testsuite dir and the testcase di=
r. I don&#39;t feel super strongly about this but in my opinion the more in=
tuitive way to present the logs would be without writing 1 file to two loca=
tions.</div><div>3. Another open question... is it better to provide this c=
urrent level of granularity (testcase logs), or better to just provide the =
top level log file and the testsuite logs? My initial impression is that wi=
th the tree structure, the high number of log files is basically harmless, =
and would provide a quick path to finding the specific logs one wants (when=
 they know the failing testcase) so I&#39;m not requesting a change... just=
 raising the point for discussion.</div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex"><br>
2.43.0<br>
<br></blockquote><div><br></div><div>Reviewed-by: Patrick Robb &lt;<a href=
=3D"mailto:probb@iol.unh.edu">probb@iol.unh.edu</a>&gt;</div><div>Tested-by=
: Patrick Robb &lt;<a href=3D"mailto:probb@iol.unh.edu">probb@iol.unh.edu</=
a>&gt;</div></div></div>

--00000000000013ea3d063c227a5f--
