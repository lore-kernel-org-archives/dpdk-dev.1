Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6ABCD98CE
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 16:58:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C63F743352;
	Thu, 11 Jun 2026 18:58:55 +0200 (CEST)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com
 [209.85.222.179])
 by mails.dpdk.org (Postfix) with ESMTP id B31EB40279
 for <dev@dpdk.org>; Thu, 11 Jun 2026 18:58:54 +0200 (CEST)
Received: by mail-qk1-f179.google.com with SMTP id
 af79cd13be357-915d17e2721so10481985a.3
 for <dev@dpdk.org>; Thu, 11 Jun 2026 09:58:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781197134; cv=none;
 d=google.com; s=arc-20240605;
 b=HzXrbl1m+QtgFzHCNzGjf7CAC5S5asXyj7EL3HmYFJqWrs5m+u4XHLJlHlTKUKhqm1
 2fJ/OyLhEj7F3IXrJ1wK7/L7RYgnUs+VFonySJiQRZLgc6hHwCGrM4wdiNsXuiwJWdpt
 WcDllddhD43fIT0QyPqGksDcGRs9DgRhicItPo1d7HRKKP0wVuMQD6j/ZVhHhmmM9aka
 kn8wiT9KHXQKh3HcUQJEB9mp1Szn2UrGeRKpe2QC5J1IGRmB8Lmuhu9YZKz4SfFxi/Hj
 6TyR6s6Or/JlfziteLn0Vae59+EcD6awXDrpXZTh9Kurl9X+SfOP0btgQ0jvbUo/1c/p
 SijQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version;
 bh=lGwYqiDGQvm1aQ4Z5d60SQFiKKLr83v3LVLeACk/qW8=;
 fh=xF+uuR7mn7H4EycvgUkwvdIDZDSqg1kWKtrpkOZ3ipA=;
 b=ddElMqTkh5hITvjhThuqMRnr6RMb2EBmKKo/z9tQUSf3RtFAqXiQrPbvwc5/lgIjep
 Pag12NHLURQohAr8zMOv2pWSxA+nx9aMr43jyGeG2GO43OF3O3fb3tax6CbAkrvqJNN9
 BFQNGNvd9PMRXCqQK0Bej8G7Dl/fO5qjiLtBMw9Dne30wvovQCzezCq5eSxCpeOB+bDV
 /eZo59Nov8IHQfxgNJ0PCD63oskSj68ax1jvMcAGMSkArvIlu4zqZ5q/gG8XkYn9q87r
 Q4twxH6NU9IqAFQ7LFaCr7QDbpATHDsrv4/IwFLe0XxHuSzqjzl5wvgdP4yQBv3vPCA9
 8ioA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781197134; x=1781801934;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lGwYqiDGQvm1aQ4Z5d60SQFiKKLr83v3LVLeACk/qW8=;
 b=AS530CuBTiJwHyRSqBUFuC12NwX1XEED+7QpwD6WZadb6dykCy2NWr6T5yMu2nqN8r
 gHCGMLWdmh4XxM9LsQ8ww4P4yDPfbqX0dUo/9dDkzokHclV2gtNd6kOF9Zlc4ZmmoKrb
 31I3ss1mwR8WoF7V/ubIRoOnDvot2DhyOhNs85NeQ/viC4xc5Bz5+4kywJ4NIlOnNKm6
 aeQ3uLU0qitqsZakIKz8YLzdh7HS10THt7Tk0xX9GYfBreK3RqbSRBN0CRvXn/rXoARK
 xrf9STcfW0RUwjoXho8fbfAW8hzgpKKun5neRS2H6+UwvhG3vKz/dnoILhIUE60Zr2/p
 zMfg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+ajujW0OKBzClHyVyCU/STEYVnJoteQALRlP0V2UJEc+sBiybBzQUE2jWLga7/zpH2f9Q=@dpdk.org
X-Gm-Message-State: AOJu0Yxyav8N7k2fVHafR04DJvTtkFaYWV7x+PGsYBcrDowsdK8iZVdB
 7sjxc9VcMyyypI1LLJ2G0lAjSWKJNFHt9aASLS4EE6d4+u+RjwT/FGi58ZWHClHxQy9/8Q/jjJk
 eh72IV2YVhRme4okH8vDCOvu6sieVsXY=
X-Gm-Gg: Acq92OGTm+SxOh8SZeW49yp35GFt3QBHwSqmHhjNuzwl5bjpGlnEMHGUMbjesqhLQPY
 D8DMWuF4EI2JHnRWVBiug6EruUfFs2Ds/shEfDuFxmgii3p5nCCFLRXHl9KkByNiYXvdr3E8LYi
 R1qBNFd1D3pziz7odDz1SrJfWLfv2A3ZzjC2cXe3FDnTauKQn3dCg0ZwOW5JcEQQsigNuCPcZ+x
 fy0QIm+MqyOI0BCe2b3wOW3Ls+j7Lf1yMux4UhH7jKpWu0M7denHGXzOoYz+dS5zzdZLKgAuJET
 Jvo6Dui/QfimyRqsHNZ5LbLWxAi+RztyJyTWvSHf
X-Received: by 2002:a05:620a:4687:b0:915:8e6d:35c4 with SMTP id
 af79cd13be357-9160ac9fd6dmr555415285a.3.1781197133913; Thu, 11 Jun 2026
 09:58:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260611154926.392670-1-maxime@leroys.fr>
 <20260611154926.392670-10-maxime@leroys.fr>
 <98CBD80474FA8B44BF855DF32C47DC35F65908@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65908@smartserver.smartshare.dk>
From: Maxime Leroy <maxime@leroys.fr>
Date: Thu, 11 Jun 2026 18:58:42 +0200
X-Gm-Features: AVVi8Cc_rsTh6TM8Qjzz4rHqcFjGEE7rEqDoVL060UYm_Mudt2ugKg2MxsUa4Wo
Message-ID: <CAHHRULWf7oLGLs0_skYZ0ow8sdKVSLXegFhRpMf4c0ThjTk=YA@mail.gmail.com>
Subject: Re: [PATCH 9/9] net/dpaa2: drop the fake software VLAN strip offload
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
Cc: Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, dev@dpdk.org
Content-Type: multipart/alternative; boundary="00000000000071215c0653fd461d"
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

--00000000000071215c0653fd461d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeu. 11 juin 2026, 17:56, Morten Br=C3=B8rup <mb@smartsharesystems.com> =
a
=C3=A9crit :

> This patch is unrelated to the series.
>
>
> Splitting this would create an ordering problem. If the NAPI series is
merged with a software VLAN strip implementation and the cleanup removing
the fake VLAN_STRIP offload is merged separately, the two can land in
either order and leave the PMD with inconsistent Rx paths.

The new NAPI/DQRR path must match the offloads reported by the PMD at the
end
of the series. Since VLAN_STRIP is not a real dpaa2 hardware offload, this
series removes the advertised offload and the software rte_vlan_strip()
calls together, so all Rx paths remain consistent at each merge point.

--00000000000071215c0653fd461d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div dir=3D"auto"><div dir=3D"auto">Le jeu. 11 juin 2026,=
 17:56, Morten Br=C3=B8rup &lt;<a href=3D"mailto:mb@smartsharesystems.com" =
target=3D"_blank" rel=3D"noreferrer">mb@smartsharesystems.com</a>&gt; a =C3=
=A9crit=C2=A0:</div><div class=3D"gmail_quote" dir=3D"auto"><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pa=
dding-left:1ex">This patch is unrelated to the series.<br><br></blockquote>=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><br></blockquote></div></div>
<div dir=3D"auto">Splitting this would create an ordering problem. If the N=
API series is merged with a software VLAN strip implementation and the clea=
nup removing the fake VLAN_STRIP offload is merged separately, the two can =
land in either order and leave the PMD with inconsistent Rx paths.</div><di=
v dir=3D"auto"><br></div><div dir=3D"auto">The new NAPI/DQRR path must matc=
h the offloads reported by the PMD at the end</div><div dir=3D"auto">of the=
 series. Since VLAN_STRIP is not a real dpaa2 hardware offload, this series=
 removes the advertised offload and the software rte_vlan_strip() calls tog=
ether, so all Rx paths remain consistent at each merge point.</div></div>

--00000000000071215c0653fd461d--
