Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C78D77891
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 17:34:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0EAFC402E8;
	Fri, 23 Jan 2026 18:34:06 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id 8E0684021F
 for <dev@dpdk.org>; Fri, 23 Jan 2026 18:34:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1769189645;
 bh=bbMeXINVY6lwi/qlyNpcSznukNYXfX9Zt5/mXH5+1tI=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=AJtCP10/p5foH4h0bSnTO/+jE5sZZp5Ftkwm31yhtIOdMyGRz9dLjvupx7OB76ePQ
 4bibZNGDDRwl45R9tm8KX9mlPrIiVvUKiMZXUAVMxEaNm0HgD3+lN0cmpWVWH29XO2
 RB9nSzxZsZmzJJd83b6dGWvHPgXj2lEWn5iyE1MzBMRgk0BJ3SD1WLBHbJv1NITXCY
 QBQDh8sX7mLijDpyxibkpXbf7V7RDumCkJp7KENm/VQdDNZGzDd+nbsQY/R68IUdzT
 jLWYzcxqELdwn28rFCgc+fsT8aHrtefem59t/GqBXdXiEvmvx7AMrInhdFCRFR3Zrv
 aWu+4/C3gyqeg==
Received: from [IPv6:2001:718:812:27::107] (gtx107.cesnet.cz
 [IPv6:2001:718:812:27::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id 571C11180072;
 Fri, 23 Jan 2026 18:34:05 +0100 (CET)
Message-ID: <1265d9a83151bdafc5a90f6c4c2e0c80889f4592.camel@cesnet.cz>
Subject: Re: [PATCH v4 0/8] net/nfb: rework to real multiport
From: Martin Spinler <spinler@cesnet.cz>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Date: Fri, 23 Jan 2026 18:34:04 +0100
In-Reply-To: <20260122171420.6479d610@phoenix.local>
References: <20260115151656.393106-1-spinler@cesnet.cz>
 <20260122072719.505185-1-spinler@cesnet.cz>
 <20260122171420.6479d610@phoenix.local>
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

Thanks for the review, my v5 changes are described in the cover letter.

In contrast (what is not changed):
- no patch is suitable for backporting
- NULL checks was just imagination of AI I think
- 64 ports ought to be enough for anybody -> reworked,
  imho much cleaner code now

My reaction to Claude:
- AI is quiet good for commit messages generated from context
  when I'm stuck (1/8) as well for doc (8/8).
- Memory leak is in patch 4/8, not in 2/8. But yes,
  it was here and it was my fault.
- RTE_EXPORT_INTERNAL_SYMBOL seems necessary (sym_chk fails without it)
  and the __rte_internal was already there.
- Prefixing in the TAILQ_HEAD(pmd_internals_head, pmd_internals):
  it is bit misleading to me as it just defines struct
  inside .cfile, anyway, I added the nfb_ prefix.
- Went through the rte_mallocs and they are used in
  process-shared contexts, changed to calloc just in one case.

My reaction to Grok:
- I think just the Code duplication hint was relevant,
- as well as the Port selection logic.


On Thu, 2026-01-22 at 17:14 -0800, Stephen Hemminger wrote:
> On Thu, 22 Jan 2026 08:27:11 +0100
> spinler@cesnet.cz wrote:
>=20
> > From: Martin Spinler <spinler@cesnet.cz>
> >=20
> > This series implements real multiport for better user experience.
> >=20
> > The existing driver creates one ethdev/port for one PCI device.
> > As the CESNET-NDK based cards aren't capable to represent each
> > Ethernet port by own PCI device, new driver implementation
> > processes real port configuration from firmware/card and switches
> > from rte_eth_dev_pci_generic_probe to multiple rte_eth_dev_create calls=
.
> >=20
> > ---
>=20
> Wading through all the AI review...
>=20
> Things you should fix:
> - make sure all calls to snprintf() have overflow checks
> - clarity about what should be backported (Fixes/stable)
> - make sure all calls to rte_malloc et al have checks for NULL
>=20
> Things you could fix:
> - using malloc vs rte_malloc for data structures not shared
>   not a big issue; but feel free to change.
> - avoiding code duplication
> - check prefix of global variables
> - mark driver only API's as __rte_internal
>=20
> Things I can fix when merging:
> - am willing to reword commit messages for readability as needed
>=20
> Things I don't care about:
> - release notes only have to be right after series, no need for per-patch
> - looks like all new functions are internal only, not sure why review wan=
ts tests.
> - assume 64 bit port mask is a hardware limit, you won't go over in futur=
e.
> - driver internal structures do not need doxygen comments
> - don't care about any AI warnings like "if you change X in the future it=
 will break"
>=20
>=20
