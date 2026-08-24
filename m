Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE04C5DF81
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Aug 2026 20:59:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6037C400D6;
	Mon, 24 Aug 2026 22:59:54 +0200 (CEST)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42]) by mails.dpdk.org (Postfix) with ESMTP id BB919400D5
 for <dev@dpdk.org>; Mon, 24 Aug 2026 22:59:52 +0200 (CEST)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-381c51fde6bso4968850a91.2
 for <dev@dpdk.org>; Mon, 24 Aug 2026 13:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787605192;
 x=1788209992; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wuRUEN1cdt+oxQs2gP8uFHTq1NbhgULhuxh/ZwlfU3E=;
 b=iWMVxcUJqyVOrF1T0nyigk491+82AmJZo9hHFsL3KRHQpnmbPt2lxpWwE/59xkfwzl
 lmmUdw46TODHIR6yCt0JK9quJlO4QZBP6TxOfi2R7GqZxqwuxW05g2NqMbkatTk3So6i
 WdeZbFlrR1btHPmNxBR7jkIy3mv9/ebyUiDO01UT6j6K91tYOlXZBZJ2veRh1gd9krBl
 xGIxGHIdkt26ZTc1iydKeax8Ex+VJ2V2drdB6oSayz5naVyZ5eLKIvqK9o1WK/xXWdoa
 tI5pw3FAhmLrWt/I2Vg0TB8Y0NEr+JSr9rhvKc5uxrFpawcoWSv5UVfdXR4G8lQUXO0R
 iZeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787605192; x=1788209992;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wuRUEN1cdt+oxQs2gP8uFHTq1NbhgULhuxh/ZwlfU3E=;
 b=WZIpUwW9xpAdfnyZIxbdd2XIvHkTIfMzQ3DiZDO0EfMjS2s3YyXlc2Wb+GHEQaIxlG
 e5zNjc0WDIEgT34mnyZFFqNaRASGJuzZvdNjP3rGanWEsMFenpWyrW+w3/cHE9Dki9uC
 qL8wKQHo99hv+Gqy3ZaAEE3abriemhjpBqytmLZBefDFVUDeY5WcOvr9e9TwiagzZJMU
 yOACzMuqUgwKEEKYCqoJW/4V8qQy9615ikFXo+hwkfVfYIjV7fDuIdsugjF6Rnxy16lA
 hCiVOlwt7aadwU+l4Sw5rBWX1C/b+i554PnpoT33XnonlApEKNpjEkBAYIneZ+VVlbwN
 ly7Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RpI/93i4DxFr5VBZL4f/rv6AEhhJHj2onuhmvIa7UOCOEuZs5OkITdgx/ufdIKWVVBBNcY=@dpdk.org
X-Gm-Message-State: AFuF++lHKEGrihSARwYHqSBjAmg3dGdBRoIJnIy+FwKTxGYjsuRKtCuA
 I2muFDfBN1vx7/l86XbVqzrfaBjInAB5LYtwgNzX9pWWhz/XQ/a046VrBUEIUH/4Zn4=
X-Gm-Gg: AR+sD13wgVhNC/Gft8JLliDRs40+vA1cncJE1QLJA/Eig1kHItjqWIc/tYSMALe+tfB
 BVvrw6GSsXd5retFTGE/Sr4vEG5viOdnIXKM0t457RoYuKVa7Lo1xJ+zAyEp+9+vmOfZGAG0f2p
 q2AIysqVFbcrFd+2M7LCqlQo3K/n80xornJh3p23AdR5hDMyRnKlTGKIztYg+LNnp8r7GE4gmi7
 Ibv3E4LMyc3vDmbMoeMzXx7Xzcz+bXQBDqiL6ACFsfY9fymtsnOveic29LNnxGVNpeySNJJFz+5
 ciWStaAP/dxOnjMXcdWlt0yVXPqpGjqYpkMnsWqln/x1Qw/9JsQytIWr4XU/5VrraTilUYea4DE
 5V+2aqrlEBlMvWUoNodWlGSLTgrUNQ0w97Vo8ijc+N006k0zoZJCEj9R4hDyG0vDgeNGuGukRXl
 twf800eGfU82g2t4lykqzJypkG9qTy+s2o0w0UCB8dRSF2GIVojfFU4a28ullJV570FQTT1Gdkv
 9aZ2orHtke5YgHt5N6fr9UlstCGJ3R2AY1OMvyN
X-Received: by 2002:a17:90b:3b48:b0:393:1cf4:d972 with SMTP id
 98e67ed59e1d1-395dee55f7emr35563531a91.3.1787605191489; 
 Mon, 24 Aug 2026 13:59:51 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39645b82847sm989804a91.11.2026.08.24.13.59.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 13:59:51 -0700 (PDT)
Date: Mon, 24 Aug 2026 13:59:41 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: William Bland <blandwwa@gmail.com>
Cc: Changchun Ouyang <changchun.ouyang@intel.com>, Huawei Xie
 <huawei.xhw@alibaba-inc.com>, dev@dpdk.org
Subject: Re: [PATCH 1/3] net: fix VLAN insert doc comment for shared-mbuf
 error code
Message-ID: <20260824135941.2c9bea11@phoenix.local>
In-Reply-To: <20260824192228.1197189-1-blandwwa@gmail.com>
References: <20260824192228.1197189-1-blandwwa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Mon, 24 Aug 2026 15:22:25 -0400
William Bland <blandwwa@gmail.com> wrote:

> The implementation returns -EINVAL when the mbuf is shared or
> indirect, but the doc comment inaccurately stated -EPERM.
> 
> Fixes: c974021a5949 ("ether: add soft vlan encap/decap")
> 
> Signed-off-by: William Bland <blandwwa@gmail.com>
> ---
>  lib/net/rte_ether.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/net/rte_ether.h b/lib/net/rte_ether.h
> index c9a0b536c3..cb10d8fb06 100644
> --- a/lib/net/rte_ether.h
> +++ b/lib/net/rte_ether.h
> @@ -387,7 +387,8 @@ static inline int rte_vlan_strip(struct rte_mbuf *m)
>   *   The packet mbuf.
>   * @return
>   *   - 0: On success
> - *   -EPERM: mbuf is shared overwriting would be unsafe
> + *   -EINVAL: overwriting would be unsafe because mbuf is shared or
> + *            indirect, or mbuf's first segment is too short
>   *   -ENOSPC: not enough headroom in mbuf
>   */
>  static inline int rte_vlan_insert(struct rte_mbuf **m)

This patch series is good and addresses bugs. But I would like it
to go a little further by:

1. Add cc: stable@dpdk.org to bugfixes
2. Do a little more refactoring so the new function can be marked experimental
3. Be more careful in the af_packet pkt_strip flag handling
4. Use test.h unit_test_suite_runner() pattern in existing test.

Long winded AI description of same stuff...

Review: [PATCH 0/3] VLAN insert with TPID / af_packet QinQ fix

Series applies cleanly on main (d55ccd4). All three Fixes: hashes
resolve. No correctness issues in the header change or the tests;
one pre-existing flag-handling problem in the af_packet Rx path is
touched by patch 3 and should be fixed separately (see below).

Patch 1/3: net: fix VLAN insert doc comment for shared-mbuf error code

Warning: Missing Cc: stable@dpdk.org. This is a fix (has a Fixes:
tag) for text that shipped in every stable branch.

Patch 2/3: net: add VLAN insert function with a TPID argument

Warning: rte_vlan_insert_tpid() is new public API and is not marked
__rte_experimental. The precedent in the same library is
rte_ipv4_cksum_simple() in rte_ip4.h, which carries the
"@warning @b EXPERIMENTAL" Doxygen note and the attribute.

Note the complication: as structured, the stable rte_vlan_insert()
wrapper calls rte_vlan_insert_tpid(). If the latter is marked
experimental, every translation unit that includes rte_ether.h
without ALLOW_EXPERIMENTAL_API gets the deprecated-attribute warning
from inside the wrapper body, which breaks existing users of the
stable function under -Werror. Suggested structure: move the body
into an unmarked helper and have both public functions call it.

	static inline int
	__rte_vlan_insert(struct rte_mbuf **m, uint16_t tpid)
	{
		/* current body */
	}

	static inline int rte_vlan_insert(struct rte_mbuf **m)
	{
		return __rte_vlan_insert(m, RTE_ETHER_TYPE_VLAN);
	}

	__rte_experimental
	static inline int
	rte_vlan_insert_tpid(struct rte_mbuf **m, uint16_t tpid)
	{
		return __rte_vlan_insert(m, tpid);
	}

Warning: No release notes entry. A new public function in lib/net
needs a line under "New Features" in
doc/guides/rel_notes/release_26_11.rst.

Warning: The unit tests for rte_vlan_insert() and
rte_vlan_insert_tpid() (app/test/test_net_ether.c, app/test/meson.build)
are added in patch 3, the af_packet fix. They test the library API
introduced here and should be part of this patch. That also keeps
the driver fix self-contained for backporting.

Patch 3/3: net/af_packet: fix QinQ outer TPID on VLAN reinsertion

Warning: The Rx VLAN block sets RTE_MBUF_F_RX_VLAN_STRIPPED
unconditionally and then, when vlan_strip is off, relies on
rte_vlan_insert_tpid() to clear it again. The non-strip path only
ends up with correct flags because the insert helper undoes the
flag; if the insert fails the mbuf is delivered with STRIPPED set
and an error logged. This dates from d41d39bcf7 ("net/af_packet:
reinsert stripped VLAN tag"), not from this patch, but this patch
reshapes exactly that block and is the place to sort it out. Split
it: one patch that fixes the flag handling (Fixes: d41d39bcf7,
Cc: stable), then the TPID change on top. Suggested shape for the
first:

	if (ppd->tp_status & TP_STATUS_VLAN_VALID) {
		mbuf->vlan_tci = ppd->tp_vlan_tci;
		mbuf->ol_flags |= RTE_MBUF_F_RX_VLAN;

		if (pkt_q->vlan_strip) {
			mbuf->ol_flags |= RTE_MBUF_F_RX_VLAN_STRIPPED;
		} else if (rte_vlan_insert(&mbuf) != 0) {
			PMD_LOG(ERR, "Failed to reinsert VLAN tag");
			mbuf->ol_flags |= RTE_MBUF_F_RX_VLAN_STRIPPED;
		}
	}

Warning: Missing Cc: stable@dpdk.org on a bug fix. Because the fix
depends on the new function from patch 2, a backport will need that
patch as well; worth stating in the commit message so the stable
maintainers know to pick both.

Warning: The tests add a second REGISTER_FAST_TEST
(vlan_insert_autotest) to test_net_ether.c alongside
net_ether_autotest. Use unit_test_suite_runner() instead: convert
the existing test_net_ether() into a suite with TEST_CASE entries
for the four address tests, add the two VLAN insert cases, and
create/free the mempool in the suite's .setup/.teardown so the
individual cases do not need a mempool parameter. That also
replaces the fprintf()/return -1 error reporting in
test_vlan_insert() with the TEST_ASSERT macros used elsewhere in
the file.

Info: test_vlan_insert_tpid() builds a frame that already carries an
802.1Q tag and then inserts an 802.1ad outer tag, but only checks
the new outer header. Checking that the pushed-down inner tag
survived (new vh->eth_proto == RTE_ETHER_TYPE_VLAN, and the following
rte_vlan_hdr still has TCI 200 / eth_proto IPv4) is what actually
exercises the QinQ case the test is named for.

Info: alloc_frame() comment says the header is "followed by
payload_len zero bytes" but rte_pktmbuf_append() does not zero the
data; either memset the payload or drop "zero" from the comment.
