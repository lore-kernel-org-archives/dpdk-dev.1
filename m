Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D37D7C624D4
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Sep 2026 16:00:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0FC9F40E49;
	Wed,  2 Sep 2026 18:00:51 +0200 (CEST)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44]) by mails.dpdk.org (Postfix) with ESMTP id 18ED340DD2
 for <dev@dpdk.org>; Wed,  2 Sep 2026 18:00:49 +0200 (CEST)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-38759bcd877so1532409a91.2
 for <dev@dpdk.org>; Wed, 02 Sep 2026 09:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788364848;
 x=1788969648; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5DIeVY2GXHPyjzAocZYedtpU747v6E75V/WBhXiY+4w=;
 b=swKaFdMfLCpZG9e64jsGj6N94wiXs+H5jaXhW4d3XnMB+8e8a/3XFrCDtV2nhNdyJw
 oUI0i6BKIfNGM+hwG95VJUnLKVqfhaASHStuYFfPe080prubCa3q4jOmcTvfj1rZzvjB
 zbkbnD9g+uhh9Bslby7mirsM8+It06rrz6mdYUlxpcjZ5mJ2t/iJuRepnJ78W0bNEX4O
 i56jkyrNBKSfMaeeSslNulJ3omkEUDK2OdEa0y02IC1oWTgweMd8BWQMxNdR4nUaEH6M
 xfAgLxohRAWJkSu43FjPaC41jGW0DI/piKURMRcaaOEC/qAv3R9mBV8yyr0svFWE8A8m
 +MPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788364848; x=1788969648;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5DIeVY2GXHPyjzAocZYedtpU747v6E75V/WBhXiY+4w=;
 b=NwlcxtTNdsvhTF9k093L7H7g7S6Cs2qSYs1ZwG6B6TqdwzArJgrRyB4w8sv4/8u/L3
 Flb/mwF4OMcCr74HdRiCwLxWAH5wUzWXPng1Tplvv8rFIYw06xKi/dJQZFgNh/GGtU34
 0OMDb0yUrGtYUeRm1J+ewzeANt7DTROF5JGb5zHXmxC4wLpKtdYHQsnFWA38ay3akUPg
 QEG52yCbwLRCqKL8XUxPjE+epAV+YynEFGERZGUhi8jVev2VAVu+Bmnhpt+hO01hcF0+
 hodoxxWt9JUqOO0Xqqy0Vsg/lfypib+xvuT02inESglOasgaihOX1cuccRj1t510q4Sy
 9SVQ==
X-Gm-Message-State: AFuF++loyIA7o66ugtANWf6Nhrwq5WGEX5pS82n6/FQs9NoJ3qHT4ML6
 8+Al/xEKzwHpshk0tAE58tmoQ8YGces/3axLnI8X/Flmz4D71yYGbNdY6qhsX2RxR6o=
X-Gm-Gg: AYBFou02nrTlieg+QMM6QV5sjF7ZvUwdV2FB+YjxiWJOkPHxL/JT3irpqEVBvHno45E
 u47GKQZqFFMf9vk5mpDpWUxq5I2XEkRD7xE+gSZejtINV5pSrnfOq5yov+gjvb/Qqltx0RkyU4a
 Q2JN7Ir46hqJSQVWYhEj97abXY1koZOZ5wlydGqu/cK3sdAFw1XJfTBncD/hzZCqm1KvUkIl0ao
 oqDYP76jj0dZDA5RGVzyRBUS+IiVrl4uVZ5znUylBchJyavJ1B8e7Ed/TH9Q7ehAwLo/lOMjgS2
 vuwacvqRPV+Bfi1a9zJr6ULBesBzm0MVACdgnyzZ7NKaDxM2GYdRtkQC8DQ0xrPLHrdItLoGgIH
 2bWk8DHYyh5C2msz9jinjIehEwNKksjO0a1KxgC1TKESTWQ2bfT4fcbFulldaN6avOfcwfYxeHf
 /qWp8/04D0e7zdNxAX+4fw4/qLwsE5AFQanMsHHkb+NKbqdFB76vOJ89qPaBeF4mvFBs8BAUJ4g
 1nmf5TRys9K/zUWSUN6zzUCm7908dXMZmT4WwkC
X-Received: by 2002:a17:90b:4a8e:b0:38f:18f9:785 with SMTP id
 98e67ed59e1d1-39aedf73060mr7873638a91.8.1788364847581; 
 Wed, 02 Sep 2026 09:00:47 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b08767a69sm83220a91.16.2026.09.02.09.00.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 09:00:47 -0700 (PDT)
Date: Wed, 2 Sep 2026 09:00:37 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>, Konstantin
 Ananyev <konstantin.ananyev@huawei.com>
Subject: Re: [PATCH v4 2/2] mempool: introduce pile driver
Message-ID: <20260902090037.11fa587e@phoenix.local>
In-Reply-To: <20260901064331.594276-3-mb@smartsharesystems.com>
References: <20260812134756.1829613-1-mb@smartsharesystems.com>
 <20260901064331.594276-1-mb@smartsharesystems.com>
 <20260901064331.594276-3-mb@smartsharesystems.com>
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

On Tue,  1 Sep 2026 06:43:31 +0000
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> Added a new "pile" mempool driver, based on the high-performance lock-free
> "pile" stack variant.
>=20
> Changed other stack drivers to call their specific push/pop functions,
> instead of calling the generic stack push/pop API.
>=20
> Signed-off-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
> ---

FYI - pile driver is a good funny name https://en.wikipedia.org/wiki/Pile_d=
river

Did a AI review with Fable 5.1 as experiment

Review of [PATCH v4 0/2] stack/mempool: introduce pile

Applied on top of d55ccd4 ("pci: remove deprecated catch-all flag"),
built with -Dwerror=3Dtrue, and ran stack_pile_autotest, stack_autotest
and mempool_autotest; all pass on x86_64.

Patch 1/2: stack: introduce pile

Warning: the pile does not honour the capacity given to
rte_stack_create(). Bulk and solo elements are separate resources
(ceil(count / RTE_STACK_PILE_BULK_SIZE) bulk elements plus count solo
elements), so the pile can hold objects in both pools at once. A pile
created with count =3D 32 accepts 32 single-object pushes, then a
further push of 32 succeeds, giving 64 objects stored while
rte_stack_free_count() reports 0. Because count is rounded up to a
whole number of bulk elements, a single push can also exceed
capacity: a pile created with count =3D 40 accepts one push of 64. The
RTE_MIN() in __rte_stack_pile_count() hides this rather than
preventing it:

	return RTE_MIN((unsigned int)s->capacity,
			__rte_stack_lf_elems_count(&s->stack_pile.bulk) * RTE_STACK_PILE_BULK_SI=
ZE +
			__rte_stack_lf_elems_count(&s->stack_pile.solo));

This is harmless for the mempool driver, which never holds more than
mp->size objects, but RTE_STACK_F_PILE is a public flag on an API
documented as a bounded stack, and callers that rely on push failing
at capacity (as test_stack_basic() does) get different behaviour
depending on how the objects were pushed. Either account for capacity
explicitly, or document in the RTE_STACK_F_PILE Doxygen and in
stack_lib.rst that the pile is only bounded when used through the
mempool driver.

Warning: the change to RTE_MEMPOOL_MAX_OPS_IDX in
lib/mempool/rte_mempool.h is unrelated to the stack library, is not
mentioned in the commit message, and is only needed by patch 2. After
this series there are 17 RTE_MEMPOOL_REGISTER_OPS() sites in the
tree, so without the bump the pile driver's constructor fails with
-ENOSPC. Please move it into the mempool patch (or a separate
preparatory mempool patch) and say why in the log.

Warning: no release note. A new public stack flag and a new mempool
driver both need an entry in doc/guides/rel_notes/release_26_11.rst.

Info: the deterministic tests only cover bulk sizes 1 and MAX_BULK.
The fragmentation path (__rte_stack_pile_pop_frag) and the bulk-pop
retry path are only reached through the random-size multi-thread
test, which does not check contents. A short sequence such as push 32
then pop 5, pop 27, and push 5 then push 32 then pop 37 would cover
both paths with a known expected result.

Info: in test_stack_push_pop() the "goto lifo" jumps backwards into
the body of the preceding if block. It is legal C, but restructuring
so that the LIFO check is a helper called from both branches would be
easier to read.

Patch 2/2: mempool: introduce pile driver

Warning: the changes to rte_mempool_register_ops() and
rte_mempool_set_ops_byname() (duplicate-name rejection, the strlen
limit changing from >=3D to >, the new -ENAMETOOLONG return, log level
changes) are unrelated to the pile driver and are not mentioned in
the commit message. The strlen change also alters behaviour: names of
exactly RTE_MEMPOOL_OPS_NAMESIZE - 1 characters were previously
rejected and are now accepted. These belong in a separate mempool
patch with their own explanation.

Review-Result: WARNING
