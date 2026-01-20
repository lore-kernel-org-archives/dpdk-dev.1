Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15B2D2ECFD
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 02:25:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B7E274067B;
	Tue, 20 Jan 2026 03:25:54 +0100 (CET)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id 0DD284026D
 for <dev@dpdk.org>; Tue, 20 Jan 2026 03:25:53 +0100 (CET)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4801d98cf39so21159755e9.1
 for <dev@dpdk.org>; Mon, 19 Jan 2026 18:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768875952;
 x=1769480752; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KA09NBReEv9Hl8u0ISnIiA4VTPF5LBs5Oc+dCV/JWU0=;
 b=rcbYhMDsEt/RyBlM3oBIrNLkusaDb8vUvODfbw1CtpuohTPbT2qk+zjaNCN97j75g5
 n6AduHm/k3jeoz7BubsDb0+leyPdOpQ31L9oJVQe2+9eC4ztWSniz7FUv3ioyUUvPCMd
 /e/jlla0GhloxK2TjBNviTKa5oPw29LF+3CFxbfN6cO+nytaTF5jrhDXogPngOzNQiVP
 M79YicPLpdA5vayRpT6TjGrXeprtiD0+y6t79VuXXWMmliLQRzrq08zbntTAuydevLhH
 Ytn7ob0u/2d1Qgs8F5s2+pAXIz/gnpdEs+i5wBX4y38ofMk5hNC6IRbz+ZC/J6tW8/r3
 Lb5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768875952; x=1769480752;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KA09NBReEv9Hl8u0ISnIiA4VTPF5LBs5Oc+dCV/JWU0=;
 b=t1tDrDx+Czaq9EZn0ahMxuMkPg20A1oSvE2c9uVsOLJV/Whqq2nxqhUpfZ6AmvO4lg
 iwSNQJH/m1DBxxfDDzZL334k9xA4q+WI41SVhWzYsj6XtyIvR1V6orR8rACJM5ZQVYnH
 pAH2AxUriItvpv3CBeWErKHpSi7wc1Bm9q+jlHDtnxHktyYaW85VhgGO0rn7GIb9ts9V
 c0R6XE/mFW1U/QGO4rOYPkn01Ft/vA9RRi+S+PETTvkxnj9/wK/w9fadRuiW7L3K0MWD
 kMCu/msPAjfHDUr2Alcr/b2buHbnizZwIl2DoF3NJt5mavnFt/Zfaik9PeC3LlH7W/qF
 HVew==
X-Gm-Message-State: AOJu0YzhNMsG+evILqPIgkM0JNs5FA5QAZmR2YLGX21onasg0zOl89GJ
 8X6t/DVEj682ZsM3gQaOn6IXhfs2FOx/TSQ+xIHSbJib+4QAGe3C/N/Ki8L0vbf29LhN9LuzQTx
 Wpa0J
X-Gm-Gg: AY/fxX4jA77IkKWZdtDRpTOftAg0fh+hkwucVQEoShlEOAaXelQzAOWpd1lV2mgIv+X
 hXtlumzJYlVRys79PLcxK6Z8PsTYFRKoMM8msKz7s6ehXK6vO3OJT1P21aC43OXVKGA3FGBNa8K
 mypId/76E46b/mFssU3MXKQwSAYJW2vfTDKq369MZuqeW2ec9mZtEA6L0GjNobecmkHe7Ee0eJW
 LKkhowiAHeWokmP+h1XMh45Bge+jW93E3hxO0iOL0Kp5ktbkyByyLMmnF2DQ0QsUyZKgW9GZGHh
 /86HXD1izNcm4bwoa6HwA9SyLHMvgv5f9FBg68AWjrAApKcqw5LO+Ryy3SOZVY5y50pj93RYXxP
 zqelMp/JLxH8ryfqEWQmfQDuFuIqkFYbk8fIeI9vadRJjDwc9tXzJADNS43LZrTz5Xj6MzcQ2yJ
 pMZYLHFpvgerKUMqGtNO7JMOTEGMV6pMa5g+PszycK4VkBvvEieQST
X-Received: by 2002:a05:600c:45d1:b0:477:7ae0:cd6e with SMTP id
 5b1f17b1804b1-4801eab5602mr156032685e9.5.1768875952600; 
 Mon, 19 Jan 2026 18:25:52 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801fe3ae95sm97704585e9.4.2026.01.19.18.25.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 18:25:51 -0800 (PST)
Date: Mon, 19 Jan 2026 18:25:46 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: spinler@cesnet.cz
Cc: dev@dpdk.org
Subject: Re: [PATCH v2 0/8] net/nfb: rework to real multiport
Message-ID: <20260119182546.7b5ade48@phoenix.local>
In-Reply-To: <20260116164436.1649047-1-spinler@cesnet.cz>
References: <20260115151656.393106-1-spinler@cesnet.cz>
 <20260116164436.1649047-1-spinler@cesnet.cz>
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

On Fri, 16 Jan 2026 17:44:28 +0100
spinler@cesnet.cz wrote:

> From: Martin Spinler <spinler@cesnet.cz>
>=20
> This series implements real multiport for better user experience.
>=20
> The existing driver creates one ethdev/port for one PCI device.
> As the CESNET-NDK based cards aren't capable to represent each
> Ethernet port by own PCI device, new driver implementation
> processes real port configuration from firmware/card and switches
> from rte_eth_dev_pci_generic_probe to multiple rte_eth_dev_create calls.

You still are using int for queue_max_rx and tx which seems wrong.
In general, this driver code seems to use int like old C code from K&R era.
Avoid using strtol() if you only want unsigned values.

Don't use RTE_ASSERT() for error checking, it gets compiled out usually.
Instead check for snprintf overflows and return EINVAL or ENAMETOOLONG erro=
r.


Some comments from AI reviewers.


    Series-wide - =E2=9A=A0=EF=B8=8F Missing release notes for significant =
changes:
        Multi-port architecture change
        New vdev support
        Port selection feature
        New hardware support (3 card types)


More comments from AI but I don't trust these.
For example, it thinks DYNANIC is misspelling of DYNAMIC


Errors (Must Fix)

    Patch 2/8: __rte_internal not alone on its own line (nfb.h lines 343, 3=
48)

Warnings (Should Fix)

    Patch 1/8: Grammar typo "doesn't necessary corresponds" (appears in bot=
h nfb_rx.c and nfb_tx.c)
    Patch 3/8: Missing trailing newline at end of nfb_vdev.c
    Patch 5/8: Return values of nfb_nc_rxmac_init() / nfb_nc_txmac_init() n=
ot checked
    Patch 8/8: Typos "DYNANIC" and "found int the"

Info (Consider)

    Magic number 64 could be a named constant
    Minor Doxygen comment formatting
