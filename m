Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB13CA5FB3
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 16:55:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E1EDD40EF1;
	Tue, 20 Jan 2026 17:55:46 +0100 (CET)
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
 by mails.dpdk.org (Postfix) with ESMTP id 6E44440ED9
 for <dev@dpdk.org>; Tue, 20 Jan 2026 17:55:45 +0100 (CET)
Received: by mail-dl1-f54.google.com with SMTP id
 a92af1059eb24-121a0bcd364so7092906c88.0
 for <dev@dpdk.org>; Tue, 20 Jan 2026 08:55:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768928144; cv=none;
 d=google.com; s=arc-20240605;
 b=RfUXhIfIUt1n3BNdRxVMNTrPBaDrrZj6jURsVP16//IGD8OS/+2Q1iynAVt3vSQiQS
 oWq0e5cyXVySx1kXqphHVWC7kxXt/PxoRhADRu6hBj4NQDQLY4+odhix2MKwzGzhz3gi
 ugXRdp+aQeGPAgNla+lP9nd45tlhxpBRBR7ALhD6MkKQGigapTuZgf9lvB1AmsF0L5R2
 zm0Otf6FirIO+soXasu8h2ZWQWznOPuyDrWV/3UQT5IcdV5UlhEWgdyH/rM0C/eKSMDj
 UeCHb+b83E0HuECAJMhgQB37ervDtrCzPOJXnxM2RPSfckjN8t4xpRwvi7+6KVwrFnQ8
 k+0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=v5bHUJXbUlXnv/oQJyFgDusLXKihmBKN485YpWU20vE=;
 fh=5d8S47tGpkCnq6aHLKh9Rcm2IE3pdQVI6gXFIjVuT3s=;
 b=Nb5mnAgIKzmgew6ySI2RsOiMp452pGNzms0k4Qz5rfLynbOh7+bwuU82/72U1c5fva
 pkd5NoxTmbmfFJztZGdXbqKRWgpWVW+f8nODZr0LMtS09Lh3ROFfdplyxsGmve9/IlE0
 h1DGjOkDyfeUcbJEJ+u4HZRhBTkb5G4EwX8NCdsP4gRhX9xZv+eOc0xWnwvgWTWNFdk4
 nxRCZURTF7wx9OwmdlTgn+4SR5teVgniPNCVUUggtuxSSsFn+g79kyAQr+BkDZFXFuKy
 cj7mWi5pSW5cz+IeU9T+sRvnrx6Rj+LbNPJtw5mzvgTIoX0JeGANYFeJamWpesHOW5zK
 adlA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1768928144; x=1769532944; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=v5bHUJXbUlXnv/oQJyFgDusLXKihmBKN485YpWU20vE=;
 b=TvqEG/gr0TfBsCF+QNB/d+PWBUKaqAI1JZEtYoSIhMlXp3vmrDS2U50KHv/cs2pzFr
 5vIn8uOOJ8k6NGFGl8SThn6t6hxcY0Dqgynaw1yqdsJbrlYqwzScSiaT64LwJnbOFbRu
 +MwRBWLwxG9V/KTGg9ulRpB4ngGAjdSyhRUu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768928144; x=1769532944;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v5bHUJXbUlXnv/oQJyFgDusLXKihmBKN485YpWU20vE=;
 b=wCksgiO4SVHAoJh8IiPU3C/Upq7/UwrcUhxqC5qrZCAUD09FKgrw9VGvoJJOMCG5+1
 N0b4/3jGWnahRIcmqYJcqkopESkUA3sBDLROQR3FpvBwb6qwRwJm+AIZdtkSFXIytYe4
 zFWcU7jGz6AODJJoG75YDQX6ZVBSKOWjp2n9/fgCHmWz6Z2NncHiXtOdE/eI1FNQPTfk
 gYJv3RaChk6f5ckG3yNeuW6R6odWigSsG7Ukv1COKF+pmVeuWB52HhbdWcoS5pKUduYo
 LLTqERX6tqGsDlC9NZ6MoJcC49mVD++thzHTjLhaxWHwHFlUh8Qi13tIafpnu245GIxF
 CvIw==
X-Gm-Message-State: AOJu0Ywp52MCjNVbkOqBnjf1NK8/WoJxzOFtLWeHe7je4A1R54gE7dLV
 IFW1O1CzMvlccaWaesSwLPuOZxysR6LeXsNJq/D5YeiuTwBykAEYDGIlsfzLz+KkL2fEId6tjvd
 HEvc8uwIiZgSz0jytPBew1afzA3ZuFNxr1V+V76YhqA==
X-Gm-Gg: AY/fxX6qVdzewpqM/RvUr5h/JXkuKkowW7BLeRgtn13eSer8EZEG/FSndulOH+Nl7Un
 Lw41lAzGIoMM8CRYVAlytxLI5VI5Nn0TMCFyT1pacoPNGpVstSsjLBUfZTBVLN1AkvcbRyBzWDF
 yUAM6kVmehegcdGrizXZGiUP0Nh5ASaN+HBkON3docvZGpqOPRkcGfPk80/KlnNZH8d8zeuaXmH
 6n2/4ZUmrNUHHVN2OvlmHUM7IcnKk5QZzfFtjuFXdhQXGxKc2fnz6sK87k/B2QzcY3utLR+4+lZ
 UFLT1SA8cOFIRyxCIQUkQBF9jrzgx5nIjnP+eKNw/A==
X-Received: by 2002:a05:7022:6291:b0:11b:b2f5:a1f4 with SMTP id
 a92af1059eb24-1244a77ad52mr10671150c88.39.1768928144228; Tue, 20 Jan 2026
 08:55:44 -0800 (PST)
MIME-Version: 1.0
References: <cover.1768518003.git.sismis@dyna-nic.com>
 <366f384e90cce0867652231494d8c873066b5fe6.1768518003.git.sismis@dyna-nic.com>
In-Reply-To: <366f384e90cce0867652231494d8c873066b5fe6.1768518003.git.sismis@dyna-nic.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Tue, 20 Jan 2026 11:53:28 -0500
X-Gm-Features: AZwV_QhINFDbhoS6hnLwgLZpsEIjVc6FZIRfhFPgUYQSxgcxxMq0cznyKJiO0aY
Message-ID: <CAJvnSUAdWtn4vo_8mGU1T59U4ryVm18nnwPy-V6hYNmb0rdeyw@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] dts: fix invalid f-string syntax in testpmd API
To: Lukas Sismis <sismis@dyna-nic.com>
Cc: dev@dpdk.org, stable@dpdk.org, 
 "NBU-Contact-Thomas Monjalon (EXTERNAL)" <thomas@monjalon.net>
Content-Type: multipart/alternative; boundary="000000000000ab93ee0648d4ad3f"
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

--000000000000ab93ee0648d4ad3f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Looks good to me, thanks for finding this issue. And, since we do need the
'enable' strings to be templated in right, I am asking Dean to re-run this
testsuite with your patch applied.

Thomas, I gather this series will not be applied/go through next-dts since
it is not primarily a DTS series, but please let me know if it should. I am
asking you since I see it is delegated to you on Patchwork.

Reviewed-by: Patrick Robb <probb@iol.unh.edu>

On Thu, Jan 15, 2026 at 6:02=E2=80=AFPM Lukas Sismis <sismis@dyna-nic.com> =
wrote:

> The f-string syntax was missing the 'f' prefix, causing
> string interpolation to fail.
>
> Fixes: cfd851f264 ("dts: add QinQ strip and VLAN extend to testpmd shell"=
)
> Cc: stable@dpdk.org
>
> Signed-off-by: Lukas Sismis <sismis@dyna-nic.com>
> ---
>  dts/api/testpmd/__init__.py | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/dts/api/testpmd/__init__.py b/dts/api/testpmd/__init__.py
> index a20dedc25a..703cae487e 100644
> --- a/dts/api/testpmd/__init__.py
> +++ b/dts/api/testpmd/__init__.py
> @@ -227,7 +227,7 @@ def start_tx_first(self, burst_num: int, verify: bool
> =3D True) -> None:
>              InteractiveCommandExecutionError: If `verify` is :data:`True=
`
> and forwarding fails to
>                  start or ports fail to come up.
>          """
> -        self.send_command(f"start tx_first {burst_num if burst_num is no=
t
> None else ""}")
> +        self.send_command(f"start tx_first {burst_num if burst_num is no=
t
> None else ''}")
>          if verify:
>              # If forwarding was already started, sending "start" again
> should tell us
>              start_cmd_output =3D self.send_command("start")
> @@ -898,11 +898,11 @@ def set_qinq_strip(self, port: int, enable: bool,
> verify: bool =3D True) -> None:
>              vlan_settings =3D self.show_port_info(port_id=3Dport).vlan_o=
ffload
>              if enable ^ (vlan_settings is not None and
> VLANOffloadFlag.QINQ_STRIP in vlan_settings):
>                  self._logger.debug(
> -                    f"Failed to {"enable" if enable else "disable"}"
> +                    f"Failed to {'enable' if enable else 'disable'}"
>                      f"QinQ strip on port {port}: \n{qinq_cmd_output}"
>                  )
>                  raise InteractiveCommandExecutionError(
> -                    f"Failed to {"enable" if enable else "disable"} QinQ
> strip on port {port}"
> +                    f"Failed to {'enable' if enable else 'disable'} QinQ
> strip on port {port}"
>                  )
>
>      def set_mac_address(self, port: int, mac_address: str, verify: bool =
=3D
> True) -> None:
> @@ -1535,7 +1535,7 @@ def set_port_mbuf_fast_free(
>              InteractiveCommandExecutionError: If mbuf_fast_free could no=
t
> be set successfully.
>          """
>          mbuf_output =3D self.send_command(
> -            f"port config {port_id} tx_offload mbuf_fast_free {"on" if o=
n
> else "off"}"
> +            f"port config {port_id} tx_offload mbuf_fast_free {'on' if o=
n
> else 'off'}"
>          )
>
>          if verify and "Error" in mbuf_output:
> --
> 2.43.7
>
>

--000000000000ab93ee0648d4ad3f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Looks good to me, thanks for finding this issue. And, sinc=
e we do need the &#39;enable&#39; strings to be templated in right, I am as=
king Dean to re-run this testsuite with your patch applied.=C2=A0<div><br><=
/div><div>Thomas, I gather this series will not be applied/go through next-=
dts since it is not primarily a DTS series, but please let me know if it sh=
ould. I am asking you since I see it is delegated to you on Patchwork.</div=
><div><br></div><div>Reviewed-by: Patrick Robb &lt;<a href=3D"mailto:probb@=
iol.unh.edu">probb@iol.unh.edu</a>&gt;</div></div><br><div class=3D"gmail_q=
uote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, J=
an 15, 2026 at 6:02=E2=80=AFPM Lukas Sismis &lt;<a href=3D"mailto:sismis@dy=
na-nic.com">sismis@dyna-nic.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">The f-string syntax was missing the &#39;f=
&#39; prefix, causing<br>
string interpolation to fail.<br>
<br>
Fixes: cfd851f264 (&quot;dts: add QinQ strip and VLAN extend to testpmd she=
ll&quot;)<br>
Cc: <a href=3D"mailto:stable@dpdk.org" target=3D"_blank">stable@dpdk.org</a=
><br>
<br>
Signed-off-by: Lukas Sismis &lt;<a href=3D"mailto:sismis@dyna-nic.com" targ=
et=3D"_blank">sismis@dyna-nic.com</a>&gt;<br>
---<br>
=C2=A0dts/api/testpmd/__init__.py | 8 ++++----<br>
=C2=A01 file changed, 4 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/dts/api/testpmd/__init__.py b/dts/api/testpmd/__init__.py<br>
index a20dedc25a..703cae487e 100644<br>
--- a/dts/api/testpmd/__init__.py<br>
+++ b/dts/api/testpmd/__init__.py<br>
@@ -227,7 +227,7 @@ def start_tx_first(self, burst_num: int, verify: bool =
=3D True) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0InteractiveCommandExecution=
Error: If `verify` is :data:`True` and forwarding fails to<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0start or port=
s fail to come up.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.send_command(f&quot;start tx_first {burst=
_num if burst_num is not None else &quot;&quot;}&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.send_command(f&quot;start tx_first {burst=
_num if burst_num is not None else &#39;&#39;}&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if verify:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# If forwarding was already=
 started, sending &quot;start&quot; again should tell us<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0start_cmd_output =3D self.s=
end_command(&quot;start&quot;)<br>
@@ -898,11 +898,11 @@ def set_qinq_strip(self, port: int, enable: bool, ver=
ify: bool =3D True) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vlan_settings =3D self.show=
_port_info(port_id=3Dport).vlan_offload<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if enable ^ (vlan_settings =
is not None and VLANOffloadFlag.QINQ_STRIP in vlan_settings):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._logger.=
debug(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&qu=
ot;Failed to {&quot;enable&quot; if enable else &quot;disable&quot;}&quot;<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&qu=
ot;Failed to {&#39;enable&#39; if enable else &#39;disable&#39;}&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0f&quot;QinQ strip on port {port}: \n{qinq_cmd_output}&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Interac=
tiveCommandExecutionError(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&qu=
ot;Failed to {&quot;enable&quot; if enable else &quot;disable&quot;} QinQ s=
trip on port {port}&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&qu=
ot;Failed to {&#39;enable&#39; if enable else &#39;disable&#39;} QinQ strip=
 on port {port}&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0)<br>
<br>
=C2=A0 =C2=A0 =C2=A0def set_mac_address(self, port: int, mac_address: str, =
verify: bool =3D True) -&gt; None:<br>
@@ -1535,7 +1535,7 @@ def set_port_mbuf_fast_free(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0InteractiveCommandExecution=
Error: If mbuf_fast_free could not be set successfully.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mbuf_output =3D self.send_command(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;port config {port_id} tx_=
offload mbuf_fast_free {&quot;on&quot; if on else &quot;off&quot;}&quot;<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;port config {port_id} tx_=
offload mbuf_fast_free {&#39;on&#39; if on else &#39;off&#39;}&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if verify and &quot;Error&quot; in mbuf_o=
utput:<br>
-- <br>
2.43.7<br>
<br>
</blockquote></div>

--000000000000ab93ee0648d4ad3f--
