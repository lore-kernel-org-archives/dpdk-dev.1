Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00AFF483E5
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Mar 2026 19:14:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F3BD3402D6;
	Mon, 23 Mar 2026 20:14:53 +0100 (CET)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com
 [209.85.208.47]) by mails.dpdk.org (Postfix) with ESMTP id 40DBC40268
 for <dev@dpdk.org>; Mon, 23 Mar 2026 20:14:53 +0100 (CET)
Received: by mail-ed1-f47.google.com with SMTP id
 4fb4d7f45d1cf-66970715adbso3486652a12.3
 for <dev@dpdk.org>; Mon, 23 Mar 2026 12:14:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774293293; cv=none;
 d=google.com; s=arc-20240605;
 b=Nn/ytGe1AeiklxmiU4KwAfjikz8c7JY1o1WLpFB857TSEH+ODDN+BXMJIMGSjAeX0B
 y+QiDzNDS5dPbCVBkAaPj+wRr+CjHGRl/QXtGJe+BI9pCHBVR1Vwx3xUAH3n8CpLkPJl
 NHV50ue24J9v87fazACDbFIbbpEgdJWKpCAwoa1QYlGxm9F8KvChpyV+j6b3OjZ4Gf64
 EvmNwb32+1qm8WLHeo9hYeBOZ0X0suYGnvqFguHVTvRusGPfnoryFg/BkboVU9TCL5+q
 3U0ktp4w49guP4+EJWEuce+KUO5F7AuljbcTxrsMw+9Lodq4jdTvcoojRFYOChS1cqds
 dKDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=nmH9iAepOX5tzgLc/HLc4Cso83sffgAmvKrIeVt9Ds8=;
 fh=r6brBWD1RX962s0Y3X947WscE5foL7hzzw11qbYmEzE=;
 b=HhKVJEqGDfkK7sBYrP+VNhqdH+xFsxrOi1OQ3M9lGf6PSZuuiXkAaEIb8SNkgGMfln
 XoNaWmQYvY7QXVz/HqiWT/RHVnbXIcbPrVCQzEIAPuSAj0XfGZ0cZ5/Gz5t03eDF3oC+
 qAmhm6QuLLZWHo1TxresxoG8HWiDEDh0PVPrWSzGAHV7qEQGuBPnhT7W6t5NkPxljVJh
 7jHFE6i6K00JEzH9gI56iOz9m/DZXDQ5yHS+H9p7AJLvOyqMdbkyaXltmHyRwrhrOSPU
 yCHTbHPh6qmxPCaE2IPIx8eHrhCC3NqoxqjhfhUO21khfFCkd17VNYuu7UWNdktbQZ7X
 X4lw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1774293293; x=1774898093; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nmH9iAepOX5tzgLc/HLc4Cso83sffgAmvKrIeVt9Ds8=;
 b=BR3K9njf/JDfNj2DDdD+2Bcsx0BwSmsSV6pW3IMYANtgTDqCQXGGpAV1C+jzJoNgJg
 4YcdJ2O5Ail6ZsCdevWmaWEl/PAO1AnmGpR69znJS4XThwkX777M8jdiDUUYY3oTlTMk
 8ieFjquo3yNOaHVIp6QXMm3ueuoI7IhoxqnvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774293293; x=1774898093;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nmH9iAepOX5tzgLc/HLc4Cso83sffgAmvKrIeVt9Ds8=;
 b=WjpWQOrZVwtDwjO4+LfVw2ybJ1pJSSi55T6hzpW1EOpGhLsSTAERbYhR4/jlx2G2lC
 Em8vAIY2qSoPtSyujSP/PzejZ6RkDGe8x3vdsfP7ykeoNL/1C3ocHSEMHwFilZzl+BOV
 ZOIuUNalt9xRvTkYereoAqpHC/DifXillO7xuOcgRrVi0FrVBwnDad7f+YWkrTgwrgCU
 Hq7ig7n2NJHm2eYaZUXXFXzyERQrGJHqapWaf4Z58wlVV2mdopFSx9YBZWohXf0ztmYD
 N3J11slggxv0AIGzQyW6HUbafDcb8MC6waUVcYFwkkcg8xnrZ4j6uOw4Ftc5UF+1oPeL
 O28g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmDiTbT2N9LPCWXxhi/CriBP/navD/4bcARWhvSFN5JS/Amk6PdO0BXFK1sEGm9Cm4U3Y=@dpdk.org
X-Gm-Message-State: AOJu0YysBSpqCUjEcodoxCUN++/B1rD+381vyQftqxWgsdErAcDrvHtO
 whoMfdz6/ZnXENvSbdpyV+wFuRYY2BP780viqF7KYFifNBVRtCDj91+sI3rMWQwd35N9uGz+kP7
 1p+oBMjoAcc5ia0OFRGyGYD7t0H/ZXMawkzhcCildZQ==
X-Gm-Gg: ATEYQzzPtBf0o5lUvb946g62ExwWcgHJcctV5lxUKZByrVAXuA97ewVMTSrfp0+UpUb
 0LtbOby/Ydzawi210hlnJ3NVQ3xz38PeAJLEPvgZehI8m5cWfD3YAz28NBcdY2lxxszuWb1Aymt
 zO6jgOnoCs1PSpibaoOlUeR+UOU/WuW+WtQYrdKM+uhcg/2FL6nXjPYjh94KsthwSFNrgFICgRi
 aZnosaccAxMpPya3DXlOIg0foWjUENhhH2nQwI/K2w4028jP2fxX9Xhkx+0DUYhH3+T5lUYNwT7
 fYmSZCJXSST74/AUysLUogBUHZUXQ33LwvYQB0d/
X-Received: by 2002:a17:907:75ec:b0:b98:2732:3dd1 with SMTP id
 a640c23a62f3a-b982f3b712amr794889066b.42.1774293292630; Mon, 23 Mar 2026
 12:14:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260323180818.674041-1-probb@iol.unh.edu>
 <20260323180818.674041-2-probb@iol.unh.edu>
In-Reply-To: <20260323180818.674041-2-probb@iol.unh.edu>
From: Andrew Bailey <abailey@iol.unh.edu>
Date: Mon, 23 Mar 2026 15:14:40 -0400
X-Gm-Features: AQROBzACwJaCUzmBaJYDMA-QaoGmdv-lG-opefZhfQcIP0EjRPDJIfPSNK4PtEo
Message-ID: <CABJ3N2XgBDw+DezbibLcvNQOd+-6Vf1+KbPdOc4C3FhxVTbnpw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] dts: always use ethdev ports to check capabilities
To: Patrick Robb <probb@iol.unh.edu>
Cc: luca.vizzarro@arm.com, dev@dpdk.org, dmarx@iol.unh.edu, 
 knimoji@iol.unh.edu, Paul.Szczepanek@arm.com
Content-Type: multipart/alternative; boundary="0000000000006f5705064db5d97f"
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

--0000000000006f5705064db5d97f
Content-Type: text/plain; charset="UTF-8"

Tested-by: Andrew Bailey <abailey@iol.unh.edu>
Reviewed-by: Andrew Bailey <abailey@iol.unh.edu>

--0000000000006f5705064db5d97f
Content-Type: text/html; charset="UTF-8"

<div dir="ltr"><div dir="ltr">Tested-by: Andrew Bailey &lt;<a href="mailto:abailey@iol.unh.edu">abailey@iol.unh.edu</a>&gt;<br>Reviewed-by: Andrew Bailey &lt;<a href="mailto:abailey@iol.unh.edu" target="_blank">abailey@iol.unh.edu</a>&gt;</div>
</div>

--0000000000006f5705064db5d97f--
