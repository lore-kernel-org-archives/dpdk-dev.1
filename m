Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C4F8D2ED0F
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 15:16:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 718C740E3A;
	Tue, 20 Jan 2026 16:16:35 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id 28FC740E32
 for <dev@dpdk.org>; Tue, 20 Jan 2026 16:16:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1768922193;
 bh=6dgpPd6ZB/bL3HFyPDz+W5eatKIksI/dn7on2wTPw/E=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=ZP1YACX4kKlw/gZPYn8Ri2xcwgtOIVSmAjojGrzjvtVRuBwlFetZ+HM5XiPisHWTV
 Sf9ho1WNgryIL6FT8+xzAvfWC/CogNC3P8/UTqvRLAUZKjMRbbT6najTJMl9VXbjWs
 3ybHHde7tSaKNjf1ZOapvn/+sHCmFJP17Dwr5EAHbgV8/HpfJTNfJsq+20mm31cOrp
 ZDl2sVIZ6agujk2+eJEBIq5VjVQdVkMQMPcRkuL3xxp5ZYUrfTBVB4pMy9s2ciiDNv
 IapvgsH2Q6hlVVxf5U6OXweLFUyCqfNpb6AgDkGIgPmAMLCv+lzEj+cqWn7H521WT/
 l+r7lulsnCH7A==
Received: from [IPv6:2001:718:812:27::107] (gtx107.cesnet.cz
 [IPv6:2001:718:812:27::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id B68B31180072;
 Tue, 20 Jan 2026 16:16:33 +0100 (CET)
Message-ID: <afd65dccb345f3407135dd24f0388986d939e1fc.camel@cesnet.cz>
Subject: Re: [PATCH v2 0/8] net/nfb: rework to real multiport
From: Martin Spinler <spinler@cesnet.cz>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Date: Tue, 20 Jan 2026 16:16:33 +0100
In-Reply-To: <20260119182546.7b5ade48@phoenix.local>
References: <20260115151656.393106-1-spinler@cesnet.cz>
 <20260116164436.1649047-1-spinler@cesnet.cz>
 <20260119182546.7b5ade48@phoenix.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
MIME-Version: 1.0
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

On Mon, 2026-01-19 at 18:25 -0800, Stephen Hemminger wrote:
>=20
> You still are using int for queue_max_rx and tx which seems wrong.

The queue_maP_rx problem I'm describing in another email.

> In general, this driver code seems to use int like old C code from K&R er=
a.
> Avoid using strtol() if you only want unsigned values.
>=20
> Don't use RTE_ASSERT() for error checking, it gets compiled out usually.
> Instead check for snprintf overflows and return EINVAL or ENAMETOOLONG er=
ror.
>=20
>=20
> Some comments from AI reviewers.
> ....

Ack. Thanks, I will incorporate all your and AI comments, except for
DYNANIC  (correct) and __rte_internal (other drivers use the same
layout).
