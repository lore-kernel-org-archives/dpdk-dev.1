Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C4FCCFA18
	for <dpdk-dev@archiver.kernel.org>; Sat,  8 Nov 2025 17:14:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F06140264;
	Sat,  8 Nov 2025 18:14:13 +0100 (CET)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54]) by mails.dpdk.org (Postfix) with ESMTP id 2501740261
 for <dev@dpdk.org>; Sat,  8 Nov 2025 18:14:13 +0100 (CET)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-3437af844afso231280a91.0
 for <dev@dpdk.org>; Sat, 08 Nov 2025 09:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762622052;
 x=1763226852; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+3ONFwPmJNHXMQqGKaxMc/voj4tyV59x2Npeq0JIkdA=;
 b=NwYXFJgVRu1+TeC6WsdALo970gGlaDhmG5/1SUUTUbIZPLVUFEDKdNwbfv+2k0JmEr
 W2/u1lzgo+R5cti8AE+NVwMtygNgdbr3let35kvorrnfuhSc/OMIYfLhF6/+sS60GnM7
 8iecDlm8Eo8wXAncIgTWzF883NL98VZY9YN7aVZ3G3kGyq8upeSnUK4hPdJn5BGtTgXV
 lMAgPSxK4REA4PxwM2bhT9r6XoUqWrNiynySduLoLdKiJKRMaza4/cYNEXaULdcjMS2n
 oLnKkPFoPevuyjitg878y/Avg+1W64TvcJ8aWPoNGj21vmK+SXlsPURHv7YE+9r4vAJe
 bRHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762622052; x=1763226852;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+3ONFwPmJNHXMQqGKaxMc/voj4tyV59x2Npeq0JIkdA=;
 b=oNBMOkoFiTLxXwxqxuwqse1RuvPOIJ32TVrWWR3sM5pcYoGvZPxHUTGC4afk/iZPrP
 NOwXKIK8PddTB9rWwn0K6G5rCos1+CpkU2ae8ovaT+nmAMC/qEFOUrKfdvR4IJu/+DMF
 ptzqis7iLhzmsD7tN4PrZcI7YGN2lBl6tXFQTnC72bam9/QHIAsLFe5cGIburlHLhxVc
 xWudXoZeyFRkP/9ECzmKSdzPkn8nJJ/247f9lhUov3q73Acso1NyDPWnT57o9o5WlO9I
 CF/ShMsGnlz/wWD0g3Vrr11HdAE6uBP+arWyi37GSunkHZglpavcucrHYBrYr6mf5SSd
 1PPw==
X-Gm-Message-State: AOJu0YyH+Hl6uEJsPGacok9fTmX2N963uvQuT3mEooGYIiROmDGZOYlV
 8sqinnl05v3l37Vbm3ZqaZ79O1Rws4k3qdZ2FZ+cjyfNxebqndAX/BJ0oJ3eGBFrbjc=
X-Gm-Gg: ASbGnculQw+ueSmxq3AGvBhwzBiNeCR6380wwGciFRG0A90avuC8UVf3tDXbbM5V2e4
 001LUeeSLg1BCpvMrZzEM/u3nj2BptLXi+TtEhB+M+X1YTcM5PPYxvsbtgbF7UAC5vcjW/VPrNt
 sA+dK0LQcCZj64UMOd+JDJZvUyy8ddaGBuAp3MuriXHYV0PBw7FyhGMnEXbEC9RgPgYvkPDqv52
 fJuQoDXDBaBS9gxZ4g5m9PrFBhkxfWIxTsVAVVwOiSdheRBWJUoZBhhaobn3Mv4YWbCtllG59Dw
 QP4xpR49vS6YOBdpNSqAnSkuiY28RGS8nR4eZJSvjaRSL070BV84GybGFza/QZkaYeNdnp7Ixo2
 vFLyQ6AVJhcfIO0BNFmfl7smOm7ySYxdVp8/rOgiVxJ23HxSfwLWqR09m6LqErmqTgE7mwFkkxO
 u9wjp0nHxclJV6TdZK7Kz8lAVwBw5I2/BYdw==
X-Google-Smtp-Source: AGHT+IFdSkqSxPMIONCcKboC1DnIyhlu7K02uyqLdv1Yf7sA1zm0dgWUeRGVaPOl+lGChCisf6elPw==
X-Received: by 2002:a17:90b:3850:b0:340:ec8f:82d8 with SMTP id
 98e67ed59e1d1-3436cb89ad0mr4599792a91.12.1762622051932; 
 Sat, 08 Nov 2025 09:14:11 -0800 (PST)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-341a696dfe9sm12831988a91.10.2025.11.08.09.14.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Nov 2025 09:14:11 -0800 (PST)
Date: Sat, 8 Nov 2025 09:14:08 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Rami Neiman <rami.neiman@solace.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, Duane Pauls <Duane.Pauls@solace.com>
Subject: Re: Question: Why =?UTF-8?B?ZG9lc27igJl0?= rte_ring use
 double-mapped VMA to eliminate wraparound logic?
Message-ID: <20251108091408.584962e8@phoenix>
In-Reply-To: <SA1PR01MB82954E1727004B247E462C269BC3A@SA1PR01MB8295.prod.exchangelabs.com>
References: <SA1PR01MB82954E1727004B247E462C269BC3A@SA1PR01MB8295.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Fri, 7 Nov 2025 16:57:37 +0000
Rami Neiman <rami.neiman@solace.com> wrote:

> Hi all,
> I have a design question regarding rte_ring that I didn=E2=80=99t find a =
historical rationale for in the archives.
> Most modern high-perf ring buffers (e.g. some NIC drivers, some DB queue =
implementations, etc.) eliminate wrap-around branches by taking the ring=E2=
=80=99s element array and mapping two consecutive VA ranges to the same phy=
sical backing pages.
> i.e. you allocate N elements, commit enough pages to cover N, then call m=
map (or equivalent) again immediately following it, pointing to the same ph=
ysical pages. So from the CPU=E2=80=99s POV the element array is logically =
[0 .. N*2) but physically it=E2=80=99s the same backing. Therefore a batch =
read/write can always be done as a single contiguous memcpy/CLD/STOS withou=
t conditionals, even if (head+bulk) exceeds N.
> Pseudo illustration:
>=20
> [phys buffer of N slots]
> VA: [0 .. N) -> phys
> VA: [N .. 2N) -> same phys
>=20
>=20
> For multi-element enqueue/dequeue it eliminates the =E2=80=9Cif wrap =E2=
=86=92 split=E2=80=9D case entirely =E2=80=94 you can always memcpy in one =
contiguous op.
> Question:
> Is there an explicit reason DPDK doesn=E2=80=99t use this technique for r=
te_ring?
> e.g.

Manipulating process mapping in user space is often non-portable, it is pos=
sible on Linux to use mmap
to do this but would require deep changes to the API.
