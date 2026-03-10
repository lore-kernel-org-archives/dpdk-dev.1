Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2356FD4F0B
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 17:25:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E8D6140672;
	Tue, 10 Mar 2026 18:25:54 +0100 (CET)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
 [209.85.218.54]) by mails.dpdk.org (Postfix) with ESMTP id F403A40662
 for <dev@dpdk.org>; Tue, 10 Mar 2026 18:25:53 +0100 (CET)
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-b94358796a1so612495666b.2
 for <dev@dpdk.org>; Tue, 10 Mar 2026 10:25:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773163553; cv=none;
 d=google.com; s=arc-20240605;
 b=k84ShHIa988dk9LPel7lvGfEhMQKMDrAVspTShWFU1AZqldI8k8tT6th0CEcP7XLCY
 Y5NOpwBwPXRgLwZPX1RiIoWMJMNHYMzivCxgRX39GTVjiWDwgJyosH2tDM0HxIJ8zLIw
 FGM09FThtPgMFUHR3y1sg5vcmqA6H+isKrHhmpZAJ9X3PjbZc+7UxpA+71jidR3zd66U
 qFzOXrfGOpfQ39vNRk2fkof+LHyjlwyV2VYWeFK+XNRexSdvwLbBXmkR/hofew3n+j6r
 rhY66Ao+It0D98ekbApJpqChm4SsTPFAmjQjmWUCO3nVOVzAGK3HhTblgnL+k/xNfJT0
 KGXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=VecfC6DAIfQ7SehKbNUvPihPWe7Vq7XJE6jPoc24LxI=;
 fh=SVEO4sx+qLDBp+vxG7jkpILDDEELOksSEocEuahrMCk=;
 b=EyCOcrHs9NVhVlxi3hiqA0xDZqlTN0e8NdgXUdSB8s5A9xSgq4Qv5cwtgNJrdFD3xz
 gYo6iP1K4CAYAuP6PL988mhTJigahGFMrYnhd+dBU4MZlfddiiyqRDzZwBCyzhx76TY9
 pzp/Ndv05PgVhoJAuNoypXg2wDf0soSzrZcofYnXSG5NQfjhFma9Mj0K7TsGFe5I80r0
 dKkKb9DL8UuA5a0UwiY6kC9ihAicAkyABX3hosmXoWK0dHJ7z92X/y9f8PB/0udFA68E
 V82dJtkzOXYHyY36HN/i19g11KGZRtR7VKP/hlLyJTLKj0q+4sFVAZHoB+sWR53cJqlA
 W6rw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1773163553; x=1773768353; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VecfC6DAIfQ7SehKbNUvPihPWe7Vq7XJE6jPoc24LxI=;
 b=I1vpwClcjsishDdotOH4XPsS8TmBYCUsNR+A6S2y7Sud9yXLKx9nOcBtn73lQuoWSH
 cInozmTeCl3/PrYozx5ld+0C997FXf+pthIZnRdHYpqiL+vRD9pnqEZI1GsCXsna8+q0
 WOaq1yuckudu/i46Kd8xAyJyJMJPhmuJuSD4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773163553; x=1773768353;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VecfC6DAIfQ7SehKbNUvPihPWe7Vq7XJE6jPoc24LxI=;
 b=R4oIw/dCex/klFD83Nxe7M/YtHjtB7UBwDxb2sAR9UthGrFayrlpb9zW/pVveK2qSw
 WA8gaY1M5CldXZsl09a0IGVroBp3dhgtO/+9RmRdUluoHrx55fblrc4KlxF9SprOAp+/
 sm5rXfKxj/MXUZDw9QWxNgERDZ0HigrNcp2k/5/wPIA+TxHRO+ClUsodFt9VJxbr2Dzf
 m+POcvfgSZL9hIXjGiKNEwyz7xc1F+cfHZwnbZOZZtqaGpsBsFf13w3sCfofmdJ2jRCD
 7fcZKIFst8EoPDEcOrTEVi+DUytgk5Tu9iteAkNw+NmuSb30V7vaEMjwVVtrLSg7l5QU
 jfMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9ia+hOapxr6IOFhGji93o2+mWKyTY7a2a0u8857gtk5++ULSMyCZ+qIK36Hcwlmfg/ek=@dpdk.org
X-Gm-Message-State: AOJu0Yz0e9/kac0NcmG3lzP7TbmDNILf4CF1KYKovdLzpw/8SL2F8KNI
 atEQG3MiwnBcRBD7UyRQpcqlf7FP0H5WXJzTsKZQ1KAQq2/FEaZh+/wv4Yeg1Sma6xA0x8tiLJo
 2iSOLBQAmy014n5xc8kgSaXRr/sGOARJRiqc/Uo7PeA==
X-Gm-Gg: ATEYQzxdEmIA8u/Dz+TZTryW5EhR86A1zF/qEW+jDPfLxR8tpc1ebqryBO/ux5t38PW
 HSNmEfJfsd4zpEoN8feiWDgR1N7aQY1p7hlGHaBXxeR9XLAWB8k1eNy05rRoDSDKCT7C8mg/Qmc
 hWbb9WQO6aGPjs7JYfas80MasLcnd76ZdMpzOddX7S56OKuCksV6OSEGSVOf/o9cUeRoFYUZRxo
 ep3v3b7LtGPv6xP1vUwnqimO520PG3AlgpjX7m0986SzJ28L4kwA/ZNPSND2Oxm7/IHpa90XDNh
 5wMjByAEfSjURjW5tCS9N9f72QnbEHi+mnwuY8ji
X-Received: by 2002:a17:906:209a:b0:b96:ff4f:11ec with SMTP id
 a640c23a62f3a-b96ff4f6c6amr276500566b.44.1773163553440; Tue, 10 Mar 2026
 10:25:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260310171028.15441-1-probb@iol.unh.edu>
In-Reply-To: <20260310171028.15441-1-probb@iol.unh.edu>
From: Andrew Bailey <abailey@iol.unh.edu>
Date: Tue, 10 Mar 2026 13:25:42 -0400
X-Gm-Features: AaiRm51vqYOkVogPs73rAG4bej4PG4pekaBCm8NvmTAMIlc_hEVTxikm58HAHns
Message-ID: <CABJ3N2Vq1hHZ+QZbFEwofHRgjDGfrv=6e4w7VYgYq5V_NiV_uA@mail.gmail.com>
Subject: Re: [PATCH v1] dts: only sniff inbound packets
To: Patrick Robb <probb@iol.unh.edu>
Cc: luca.vizzarro@arm.com, dev@dpdk.org, dmarx@iol.unh.edu, 
 Paul.Szczepanek@arm.com, manjunathgouda.hosamani@intel.com, 
 thomas@monjalon.net
Content-Type: multipart/alternative; boundary="000000000000bb58e7064caecf2f"
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

--000000000000bb58e7064caecf2f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested-by: Andrew Bailey <abailey@iol.unh.edu>
Reviewed-by: Andrew Bailey <abailey@iol.unh.edu>

On Tue, Mar 10, 2026 at 1:13=E2=80=AFPM Patrick Robb <probb@iol.unh.edu> wr=
ote:

> Add a filter to the Scapy traffic generator sniffer which
> forces the sniffer to ignore outbound traffic, preventing
> double counting of packets. Without this change sniffing
> will double count packets when DTS is being run with a
> single link topology, because the Scapy packet transmission
> and Scapy sniffing is happening on the same port. The
> correct behavior is to only count inbound traffic which is
> being returned to the traffic generator by the DTS SUT.
>
> Fixes: dfb667368077 ("dts: add Scapy asynchronous sniffer")
>
> Signed-off-by: Patrick Robb <probb@iol.unh.edu>
> ---
>  dts/framework/testbed_model/traffic_generator/scapy.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/dts/framework/testbed_model/traffic_generator/scapy.py
> b/dts/framework/testbed_model/traffic_generator/scapy.py
> index 9e15a31c00..c6e9006205 100644
> --- a/dts/framework/testbed_model/traffic_generator/scapy.py
> +++ b/dts/framework/testbed_model/traffic_generator/scapy.py
> @@ -203,7 +203,7 @@ def _sniff(self, recv_port: Port) -> None:
>          ready_prompt =3D "Ready."
>          self.send_command(
>              "sniff("
> -            f'iface=3D"{recv_port.logical_name}", quiet=3DTrue, store=3D=
False, '
> +            f'iface=3D"{recv_port.logical_name}", filter=3D"inbound",
> quiet=3DTrue, store=3DFalse, '
>              "prn=3Dlambda p: bytes_base64(p.build()).decode(), "
>              f'started_callback=3Dlambda: print("{ready_prompt}")'
>              ")",
> --
> 2.49.0
>
>

--000000000000bb58e7064caecf2f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Tested-by: Andrew Bailey &lt;<a href=3D"mailto:abailey@iol=
.unh.edu">abailey@iol.unh.edu</a>&gt;<br>Reviewed-by: Andrew Bailey &lt;<a =
href=3D"mailto:abailey@iol.unh.edu">abailey@iol.unh.edu</a>&gt;</div><br><d=
iv class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gm=
ail_attr">On Tue, Mar 10, 2026 at 1:13=E2=80=AFPM Patrick Robb &lt;<a href=
=3D"mailto:probb@iol.unh.edu">probb@iol.unh.edu</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">Add a filter to the Scapy tr=
affic generator sniffer which<br>
forces the sniffer to ignore outbound traffic, preventing<br>
double counting of packets. Without this change sniffing<br>
will double count packets when DTS is being run with a<br>
single link topology, because the Scapy packet transmission<br>
and Scapy sniffing is happening on the same port. The<br>
correct behavior is to only count inbound traffic which is<br>
being returned to the traffic generator by the DTS SUT.<br>
<br>
Fixes: dfb667368077 (&quot;dts: add Scapy asynchronous sniffer&quot;)<br>
<br>
Signed-off-by: Patrick Robb &lt;<a href=3D"mailto:probb@iol.unh.edu" target=
=3D"_blank">probb@iol.unh.edu</a>&gt;<br>
---<br>
=C2=A0dts/framework/testbed_model/traffic_generator/scapy.py | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/dts/framework/testbed_model/traffic_generator/scapy.py b/dts/f=
ramework/testbed_model/traffic_generator/scapy.py<br>
index 9e15a31c00..c6e9006205 100644<br>
--- a/dts/framework/testbed_model/traffic_generator/scapy.py<br>
+++ b/dts/framework/testbed_model/traffic_generator/scapy.py<br>
@@ -203,7 +203,7 @@ def _sniff(self, recv_port: Port) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ready_prompt =3D &quot;Ready.&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.send_command(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;sniff(&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&#39;iface=3D&quot;{recv_port.l=
ogical_name}&quot;, quiet=3DTrue, store=3DFalse, &#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&#39;iface=3D&quot;{recv_port.l=
ogical_name}&quot;, filter=3D&quot;inbound&quot;, quiet=3DTrue, store=3DFal=
se, &#39;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;prn=3Dlambda p: bytes=
_base64(p.build()).decode(), &quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0f&#39;started_callback=3Dla=
mbda: print(&quot;{ready_prompt}&quot;)&#39;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;)&quot;,<br>
-- <br>
2.49.0<br>
<br>
</blockquote></div>

--000000000000bb58e7064caecf2f--
