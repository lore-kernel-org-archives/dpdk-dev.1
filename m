Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B4FCA5FA2
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 16:46:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1AEA440ED9;
	Tue, 20 Jan 2026 17:46:16 +0100 (CET)
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by mails.dpdk.org (Postfix) with ESMTP id 5644D40E0C
 for <dev@dpdk.org>; Tue, 20 Jan 2026 17:46:14 +0100 (CET)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-11f36012fb2so8056617c88.1
 for <dev@dpdk.org>; Tue, 20 Jan 2026 08:46:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768927573; cv=none;
 d=google.com; s=arc-20240605;
 b=bQ9T98BilFCJN4swGirZzuGJuN6bjEIz0bupXt8oaoJaOC0vHAiwbt5REHOeW/BGkz
 /lIDWiUULvPbPAvHbNo19nPzLJ0sCeXVtZSLD8lHiMQPKxofeoa1lguZEbDQ6I0t4Jxd
 m64LIbRefFMqlyB1C8GYzOyf+C//9tk408uXK9v9BOvz/FNKYklOvTczxIW8DjYt+MZt
 lCPvG4FWdcvLCgy6duEnSWRCIuWxg82p0ycTvyyreQo9jIQp8UjU/xeIfXZuZcJqPoMj
 BsmQbGNBPgrfgDL5Aq4lGlGEuTtymQufhRfznW5dqhSukMaZnkF+QfwXK20uaCOWtUR1
 ugWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ukCtITTG4NKGk9hWgY/VRFqJKmdKUoEpKw/utuVljP0=;
 fh=KG2BbTLy79EdxGMy3PhWjyhyQh/bw8nx5iVNHMrmtp4=;
 b=HGydmkBfQ/KLzAn7mLdr1WeUT5Yr4Iw+CmfIPAMKLBqLlFDVAf+yk+KzF9fz2pvFyp
 k40gU+f8PPZBJThhsKj0mIIWNasSSREV+D6gryDEtlrbj08bVZROxaFA56q0tM86XmPC
 mc8YJz3UwmRxMh8/yC+C7lkxouUGRr6ml9WxKOc4KdqsLvFZuHfZgOBgv4xpgJj4LXDE
 DP/NjQ0ZLLxslUN25BrswAYrBxKrCUHK/QWT5pipg+/RG37c9TrQxCghS+BPHHTcc8qq
 n5zk/ZYBwwxJL1swoynsy0PD41uHGTOk0TLHGG1sveLb0xuKHx7weiOLmk1ze6aN56ba
 B3Iw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1768927573; x=1769532373; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ukCtITTG4NKGk9hWgY/VRFqJKmdKUoEpKw/utuVljP0=;
 b=DiL6wdRR9SRwOgGLuP0IDNjhqktPnzn38+oV2adynhGBIiVC9O3ZKVEBaKP7Lx2cmr
 s7bneR9gAUIrm9m22w1fM8HPcGnC+GrLr5I4ny1cUPFuFwkybpz8VNPBdD60oGwGPhnb
 qEQkxIwrUAJwsrJzSO3qFypWwqbr95ueJpddY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768927573; x=1769532373;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ukCtITTG4NKGk9hWgY/VRFqJKmdKUoEpKw/utuVljP0=;
 b=SgJDW+AIC1I76Q1fzLj4Gacf6Ok0yim1RocoGbYOx/tw/Gy+TSm9slRBM2qZbNdn67
 KgFl/JywJFL9sdSrJi9qklXSEWtzJ3h5TUjypAMCXO5YpJra7imQbMA6AfRhoDKDOw0f
 lk8lAHbRQW9q0U9T9f1ysXPotywOEFlbrdQAi+I09fmSjrBWe9JGbcwAFdyuG6rWk1cO
 c4KfaUhxJp0Hx1FRcXmQeDy4J3b3tmA8MU/4eghn8psWkm0CXQTWSctBiD1EPwYZSQLR
 cCaF3lJlMHCIqLoO8qE/1uT1noOZiZwQoTkn2b+GPBTseAGqhzvIeLDyfYFavTdep/89
 9r4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdmJIuv6m3ww5ORPfs6bjrL9ZYGetquJ7jR2i3jPvuIkFFSi3dgHybhg6utxc0YyfhsO4=@dpdk.org
X-Gm-Message-State: AOJu0YwC9b9AhwDDB1gYN1rA7P3vYATlWcROSU+9lAs1d2OXFG/ch9/C
 AESxl84neVH5tyWQL+X3/PnsOpYVVnsVoom095sdDZIr3EE1NF+VfdvhY14cCfNza+wLKlam7y6
 dv0w+xpftWb5+ju2l5sl5KkmpHGT5uhVmzivvyMhvZg==
X-Gm-Gg: AY/fxX7RO5reDnVG5LG4ziYhIreuO7/R7U+7LypS3x9Mf90fRIUH0bcwRYJlIOVziJh
 x7oj4NuNcBRYAmLbyPOhKb02t5eMOorVafqrZEnh5KYTezZ1G+KPnIo12wcN3VbVIXwhAX9rvM6
 Y1CxdoKMuH99dz6O24bsnw6LKd4id9TQ8l5rq2oQFKf+Jok6/I/XeMtu7OKtuGPeT3hE/QcSTsv
 V4cmIyvHG35UWR1fYHdRJZchqKqxyXbHEo4mqofGlpgkdRL4jWcJXJxCo98yFOHVcce/7BvFYoa
 9Fda+N/4a987+42HZR4qeU6HbFQ2byGdVTJN4uU/M70ebTnupevT
X-Received: by 2002:a05:7022:4395:b0:119:e56b:91da with SMTP id
 a92af1059eb24-1244b3223famr11048933c88.11.1768927573258; Tue, 20 Jan 2026
 08:46:13 -0800 (PST)
MIME-Version: 1.0
References: <20251024185056.607160-3-dmarx@iol.unh.edu>
 <20251107215020.255182-1-dmarx@iol.unh.edu>
 <CAJFAV8x4g4yy3LO7bfKh-UzFZ=fA5Y0Q3hAvOamw2o4rFMbeKA@mail.gmail.com>
In-Reply-To: <CAJFAV8x4g4yy3LO7bfKh-UzFZ=fA5Y0Q3hAvOamw2o4rFMbeKA@mail.gmail.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Tue, 20 Jan 2026 11:43:56 -0500
X-Gm-Features: AZwV_QhJ64H2bYw42d9lOFMdb8It1qsgdZYWrQIC6Gy6Agpuqjtkq_nxvSpe7Z0
Message-ID: <CAJvnSUDdXrq+=KzXdMU_2oyPQwtHUbpbR6KhV3GOOThcd1G8DA@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] dts: add start Tx first method to testpmd shell
To: David Marchand <david.marchand@redhat.com>
Cc: Dean Marx <dmarx@iol.unh.edu>, luca.vizzarro@arm.com,
 yoan.picchi@foss.arm.com, 
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com, dev@dpdk.org, 
 Thomas Monjalon <thomas@monjalon.net>
Content-Type: multipart/alternative; boundary="000000000000a3446c0648d48b56"
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

--000000000000a3446c0648d48b56
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David,

Dean and I both looked at the patch from Lukas, yes it looks good and I
will add a comment and tag there.

Otherwise, I'm not sure how the patch could have been breaking docs given
our process. Can you please sanity check my process below? Maybe I am
making a silly mistake with validating the docs build.

For the next dts branch, when I'm adding new patches, for each patch:

1. Apply patchseries
2. Run normal checks (checkpatches.sh, check-git-log.sh,
dts-check-format.sh)
3. Perform a doc build like below:

meson setup my-doc-build
ninja -C my-doc-build doc

Then, It quickly does a doc build, and (although I don't always look unless
I'm making a docs change) it is possible to navigate into the build dir
docs dir, and open up the html docs files.

4. Then at the end I push my local branch with the new patches added to the
remote next-dts repo.

So, is my above docs check sufficient, or am I missing a part of the
process?

On Tue, Jan 20, 2026 at 4:13=E2=80=AFAM David Marchand <david.marchand@redh=
at.com>
wrote:

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
> > @@ -204,6 +204,27 @@ def start(self, verify: bool =3D True) -> None:
> >                  self._logger.debug(f"Failed to start packet forwarding=
:
> \n{start_cmd_output}")
> >                  raise InteractiveCommandExecutionError("Testpmd failed
> to start packet forwarding.")
> >
> > +    @_requires_started_ports
> > +    def start_tx_first(self, burst_num: int, verify: bool =3D True) ->
> None:
> > +        """Start packet forwarding after sending specified number of
> bursts of packets.
> > +
> > +        Args:
> > +            burst_num: Number of packets to send before stopping
> transmission.
> > +            verify: If :data:`True` , a second start command will be
> sent in an attempt to verify
> > +                packet forwarding started as expected.
> > +
> > +        Raises:
> > +            InteractiveCommandExecutionError: If `verify` is
> :data:`True` and forwarding fails to
> > +                start or ports fail to come up.
> > +        """
> > +        self.send_command(f"start tx_first {burst_num if burst_num is
> not None else ""}")
> > +        if verify:
> > +            # If forwarding was already started, sending "start" again
> should tell us
> > +            start_cmd_output =3D self.send_command("start")
> > +            if "Packet forwarding already started" not in
> start_cmd_output:
> > +                self._logger.debug(f"Failed to start packet forwarding=
:
> \n{start_cmd_output}")
> > +                raise InteractiveCommandExecutionError("Testpmd failed
> to start packet forwarding.")
> > +
> >      def stop(self, verify: bool =3D True) -> str:
> >          """Stop packet forwarding.
> >
>
> I can see (uncaught) warnings in GHA when generating the documentation.
> I don't know if this is something new, or if it was like this from the
> start.
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
>
> https://github.com/DPDK/dpdk/actions/runs/21163780224/job/60863594703#ste=
p:19:9587
>
>
>
> --
> David Marchand
>
>

--000000000000a3446c0648d48b56
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi David,=C2=A0<div><br></div><div>Dean and I both looked =
at the patch from Lukas, yes it looks good and I will add=C2=A0a comment an=
d tag there.</div><div><br></div><div>Otherwise, I&#39;m not sure how the p=
atch could have=C2=A0been breaking docs given our process. Can you please s=
anity check my process below? Maybe I am making a silly mistake with valida=
ting the docs build.=C2=A0</div><div><br></div><div>For the next dts branch=
, when I&#39;m adding new patches, for each patch:</div><div><br></div><div=
>1. Apply patchseries</div><div>2. Run normal checks (checkpatches.sh, chec=
k-git-log.sh, dts-check-format.sh)</div><div>3. Perform a doc build like be=
low:</div><div><br></div><div>meson setup my-doc-build</div><div>ninja -C m=
y-doc-build doc</div><div><br></div><div>Then, It quickly does a doc build,=
 and (although I don&#39;t always look unless I&#39;m making a docs change)=
 it is possible to navigate into the build dir docs dir, and open up the ht=
ml docs=C2=A0files.=C2=A0</div><div><br></div><div>4. Then at the end I pus=
h my local branch with the new patches added to the remote next-dts repo.</=
div><div><br></div><div>So, is my above docs check sufficient, or am I miss=
ing a part of the process?</div></div><br><div class=3D"gmail_quote gmail_q=
uote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jan 20, 2026 =
at 4:13=E2=80=AFAM David Marchand &lt;<a href=3D"mailto:david.marchand@redh=
at.com">david.marchand@redhat.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">Hello dts guys,<br>
<br>
On Fri, 7 Nov 2025 at 22:50, Dean Marx &lt;<a href=3D"mailto:dmarx@iol.unh.=
edu" target=3D"_blank">dmarx@iol.unh.edu</a>&gt; wrote:<br>
&gt;<br>
&gt; Add start tx_first method to testpmd shell, which sends<br>
&gt; a specified number of burst packets prior to starting<br>
&gt; packet forwarding.<br>
&gt;<br>
&gt; Signed-off-by: Dean Marx &lt;<a href=3D"mailto:dmarx@iol.unh.edu" targ=
et=3D"_blank">dmarx@iol.unh.edu</a>&gt;<br>
&gt; Reviewed-by: Luca Vizzarro &lt;<a href=3D"mailto:luca.vizzarro@arm.com=
" target=3D"_blank">luca.vizzarro@arm.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 dts/api/testpmd/__init__.py | 21 +++++++++++++++++++++<br>
&gt;=C2=A0 1 file changed, 21 insertions(+)<br>
&gt;<br>
&gt; diff --git a/dts/api/testpmd/__init__.py b/dts/api/testpmd/__init__.py=
<br>
&gt; index aadb7f4e70..6d70927660 100644<br>
&gt; --- a/dts/api/testpmd/__init__.py<br>
&gt; +++ b/dts/api/testpmd/__init__.py<br>
&gt; @@ -204,6 +204,27 @@ def start(self, verify: bool =3D True) -&gt; None=
:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._lo=
gger.debug(f&quot;Failed to start packet forwarding: \n{start_cmd_output}&q=
uot;)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise In=
teractiveCommandExecutionError(&quot;Testpmd failed to start packet forward=
ing.&quot;)<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 @_requires_started_ports<br>
&gt; +=C2=A0 =C2=A0 def start_tx_first(self, burst_num: int, verify: bool =
=3D True) -&gt; None:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Start packet forwarding=
 after sending specified number of bursts of packets.<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 burst_num: Number of packet=
s to send before stopping transmission.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify: If :data:`True` , a=
 second start command will be sent in an attempt to verify<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packet forwar=
ding started as expected.<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecution=
Error: If `verify` is :data:`True` and forwarding fails to<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 start or port=
s fail to come up.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.send_command(f&quot;start tx_first {=
burst_num if burst_num is not None else &quot;&quot;}&quot;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if verify:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # If forwarding was already=
 started, sending &quot;start&quot; again should tell us<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 start_cmd_output =3D self.s=
end_command(&quot;start&quot;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;Packet forwarding =
already started&quot; not in start_cmd_output:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.=
debug(f&quot;Failed to start packet forwarding: \n{start_cmd_output}&quot;)=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise Interac=
tiveCommandExecutionError(&quot;Testpmd failed to start packet forwarding.&=
quot;)<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 def stop(self, verify: bool =3D True) -&gt; str:<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Stop packet forwar=
ding.<br>
&gt;<br>
<br>
I can see (uncaught) warnings in GHA when generating the documentation.<br>
I don&#39;t know if this is something new, or if it was like this from the =
start.<br>
<br>
Please have a look.<br>
<br>
2026-01-20T08:16:58.5130393Z [250/252] Generating dts_api_html with a<br>
custom command<br>
2026-01-20T08:16:58.5131324Z WARNING: autodoc: failed to import module<br>
&#39;testpmd&#39; from module &#39;api&#39;; the following exception was ra=
ised:<br>
2026-01-20T08:16:58.5132132Z Traceback (most recent call last):<br>
2026-01-20T08:16:58.5132676Z=C2=A0 =C2=A0File<br>
&quot;/usr/lib/python3/dist-packages/sphinx/ext/autodoc/importer.py&quot;, =
line<br>
70, in import_module<br>
2026-01-20T08:16:58.5133175Z=C2=A0 =C2=A0 =C2=A0return importlib.import_mod=
ule(modname)<br>
2026-01-20T08:16:58.5133807Z=C2=A0 =C2=A0File<br>
&quot;/usr/lib/python3.10/importlib/__init__.py&quot;, line 126, in<br>
import_module<br>
2026-01-20T08:16:58.5134351Z=C2=A0 =C2=A0 =C2=A0return<br>
_bootstrap._gcd_import(name[level:], package, level)<br>
2026-01-20T08:16:58.5134771Z=C2=A0 =C2=A0File &quot;&lt;frozen importlib._b=
ootstrap&gt;&quot;,<br>
line 1050, in _gcd_import<br>
2026-01-20T08:16:58.5135202Z=C2=A0 =C2=A0File &quot;&lt;frozen importlib._b=
ootstrap&gt;&quot;,<br>
line 1027, in _find_and_load<br>
2026-01-20T08:16:58.5135997Z=C2=A0 =C2=A0File &quot;&lt;frozen importlib._b=
ootstrap&gt;&quot;,<br>
line 1006, in _find_and_load_unlocked<br>
2026-01-20T08:16:58.5136465Z=C2=A0 =C2=A0File &quot;&lt;frozen importlib._b=
ootstrap&gt;&quot;,<br>
line 688, in _load_unlocked<br>
2026-01-20T08:16:58.5136900Z=C2=A0 =C2=A0File &quot;&lt;frozen<br>
importlib._bootstrap_external&gt;&quot;, line 879, in exec_module<br>
2026-01-20T08:16:58.5137348Z=C2=A0 =C2=A0File &quot;&lt;frozen<br>
importlib._bootstrap_external&gt;&quot;, line 1017, in get_code<br>
2026-01-20T08:16:58.5137795Z=C2=A0 =C2=A0File &quot;&lt;frozen<br>
importlib._bootstrap_external&gt;&quot;, line 947, in source_to_code<br>
2026-01-20T08:16:58.5138259Z=C2=A0 =C2=A0File &quot;&lt;frozen importlib._b=
ootstrap&gt;&quot;,<br>
line 241, in _call_with_frames_removed<br>
2026-01-20T08:16:58.5138733Z=C2=A0 =C2=A0File<br>
&quot;/home/runner/work/dpdk/dpdk/dts/api/testpmd/__init__.py&quot;, line 2=
30<br>
2026-01-20T08:16:58.5139388Z=C2=A0 =C2=A0 =C2=A0self.send_command(f&quot;st=
art tx_first<br>
{burst_num if burst_num is not None else &quot;&quot;}&quot;)<br>
2026-01-20T08:16:58.5139819Z<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^=
<br>
2026-01-20T08:16:58.5140133Z SyntaxError: f-string: expecting &#39;}&#39;<b=
r>
2026-01-20T08:16:58.5140317Z<br>
<br>
...<br>
<br>
<a href=3D"https://github.com/DPDK/dpdk/actions/runs/21163780224/job/608635=
94703#step:19:9587" rel=3D"noreferrer" target=3D"_blank">https://github.com=
/DPDK/dpdk/actions/runs/21163780224/job/60863594703#step:19:9587</a><br>
<br>
<br>
<br>
-- <br>
David Marchand<br>
<br>
</blockquote></div>

--000000000000a3446c0648d48b56--
