Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06EB606A32D
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Nov 2026 18:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I1k6XhM7
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 66509402E1;
	Tue, 24 Nov 2026 19:05:51 +0100 (CET)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by mails.dpdk.org (Postfix) with ESMTPS id E078040279
 for <dev@dpdk.org>; Tue, 24 Nov 2026 19:05:49 +0100 (CET)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a5177d78c7so47354355e9.2
 for <dev@dpdk.org>; Tue, 24 Nov 2026 10:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795543549; x=1796148349; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=JDA+41Dw48NPi0uYfMy4ve/44fhHZZXA5BGzr5I2Z7U=;
 b=I1k6XhM7UNOr8CymmOpWwa1UuT55FYoxfmf+DCoY+Cav75qnKgPx7/QuOy7CNfxi5T
 eNx0Kq9kNFOv7gtZ5AV4KjrrbzqVS4O6uKPEJbcIIjbPWk+ePtYEddVbKN/A5DK1Ohut
 rvcpRkpVfKHpW1T8LLBmK7e9FGdX10R4dElMGE2ZBsgE+mdXo2HmAebDyZO7kToBjOdG
 tCKEBXd7vMXNGrc9XpsPdQaIA3g8gquTgbC2/BCdLJJS8DVPs1fqSElkhnxzmoan7WGc
 Yf0Ohe322qFXoch1G4y6s3S69JJBNF8aZpYpadgDAjC3CIAP0PaJ0UwvHqOzRNJMbEVD
 MuFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795543549; x=1796148349;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JDA+41Dw48NPi0uYfMy4ve/44fhHZZXA5BGzr5I2Z7U=;
 b=GHYAhgIc5fw1feAzdh9kylflCBJ0cx3YVdLKfCCG1KVx0ngv1UVH5S7C14zhYCatt6
 VloSall6nejoFDSchCmojAdwjZOS3IA1QhrpOdgfcewMElcNb0mv6MddFBWN1R52mqt2
 pi9ryNGhpSe7s8fpjHI9UJ1r7Mk0US7ZTafedwe+36gEG0PxuZ0/TKCrU5c/wglop4Nh
 EhNcT/pIGh/m4pq2ULQPalI0O4A03GUZxRxmxouZIZ5xIKnHJbmNHbLc7BNmugfHZukG
 MnHVNtrPGAPyWOc7eianoCu9BSl1GVGHyybYp4bfsMRzcJ0jCl0PCfYb6UrO9tVBb4RL
 Zmtw==
X-Gm-Message-State: APuU4Z/41T8ZhD1NE13Zw4gBjtaGUulXtknSgjmUtt0Lmg9QmhH5rltG
 4vdqDYgu4ukx0dJNhYgS1Wt8BmfwfjlyIcydMruoZ8yo7E7OFyB6IUx6
X-Gm-Gg: AZFdTZdCHtImFMLErT79yl0VxirTaaTEcTps0GGcGyH86ZPS1wNsMIYyKY3qH7iq1KL
 Cqn6UyWtex5Mh3D2hh6KcOOw43DJlZ4vMIdNqxfruO2KTDE+qVqOo7CoObDaweF1PbNNCSC7jUd
 YgkjvMDomSvNsOC4xD8Uat95mHldy3ALT5muZPIeifSYffV2udjllH8P7tTtmJmbFB9c8ixNkpH
 YDcHK0xYijpLoho1PMtvA02L0x85YyotgKgwWRQDO0vSf2qzXYpmi6Mb734FYhhqD7pVD3Yr8wN
 0cz2rWuUJN8T4EMIQT9CqpETiY2CF8s3PBOSnC9ne1iqGDKkHA6rFJtUx1cP+qtuFxgVCFl/dE+
 i6cLXrI03HGtUl6Vu73qToXgkvCnsyfp9ogp848SkCXOGCToTbWHzW+l3pK86g//xzbrCmavfyn
 zY4rGaOILxNGoNZIC90G256q32jHFcCFAgP1b7OG/CZwQWwKNTLylNl8zkpcHOaqnXxVMUzGZrs
 ii5cwz3abBq6MJfqcHl/xOWedx8dQ8RLynLzRF7iSnlKzN2MPrk6NSKYRJpt8Mpg5t8N28GJelO
 CMg8Kx7SqBv7mSIXJXgIaisljv9Q/QNHSUVWE86wn8UHsxulgU8KmX6IAT77
X-Received: by 2002:a05:600c:4f4a:b0:4bb:6752:8413 with SMTP id
 5b1f17b1804b1-4bb8880015bmr355679915e9.8.1795543549346; 
 Tue, 24 Nov 2026 10:05:49 -0800 (PST)
Received: from freepad.home ([2a01:e0a:1248:bd70:ee15:c1ae:fed0:c345])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8d4f9aa8sm412701505e9.4.2026.11.24.10.05.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 10:05:48 -0800 (PST)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: vladimir.medvedkin@intel.com
Cc: dev@dpdk.org,
	rjarry@redhat.com,
	Maxime Leroy <maxime@leroys.fr>
Subject: [RFC 0/5] fib: lookup across a group of FIBs
Date: Tue, 24 Nov 2026 19:04:10 +0100
Message-ID: <20261124180415.1099828-1-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A burst may carry packets of several VRFs. An application keeping one
FIB per VRF then calls rte_fib_lookup_bulk() once per packet, or
regroups the burst per VRF before the lookup.

This RFC adds a group of FIBs: FIBs created with the same type, flags
and next hop size join a group, and rte_fib_group_lookup_bulk() looks
up each address in its own FIB with one call, given one dataplane
pointer per address (rte_fib_get_dp()). In DIR24-8 the TBL24 sits at a
fixed offset from that pointer, so the lookup does the same memory
accesses as a lookup in a single FIB. The FIBs stay independent: each
one is created when its VRF is, sized on its own, and freed with it.

It is an alternative to the multi-VRF FIB discussed with Vladimir,
for applications that keep one FIB per VRF.

Usage:

    grp = rte_fib_group_create(&grp_conf);
    conf.group = grp;
    fib = rte_fib_create(name, socket_id, &conf);
    ...
    rte_fib_group_lookup_bulk(grp, dps, ips, next_hops, n);

Lookup cost with "dpdk-test-fib -- -f <routes> -e 8 -G 4 -v s1":
4 FIBs with a full view each (1,075,223 routes), a random FIB per
address, scalar lookup, cycles per address, median of 3 runs on a
laptop with --no-huge:

                          test-fib order   random order
  group lookup                 40.2            39.5
  one call per address         59.5           105.2

"test-fib order" is the default of the tool, where the addresses follow
the route file. "random order" is the same 10M addresses shuffled and
read with -t, which needs patch 4 (also sent alone as a fix):

    dpdk-test-fib -- -f <routes> -l 10000000 -u addrs.txt
    shuf addrs.txt > shuffled.txt
    dpdk-test-fib -- -f <routes> -t shuffled.txt -e 8 -G 4 -v s1

"one call per address" is rte_fib_lookup_bulk() called on the FIB of
each address with one address, what an application does without a
group lookup.

The AVX-512 lookup (-v v --force-max-simd-bitwidth=512) is faster in
the test-fib order (30.2) but not in random order (39.9).

Open questions:
- ABI: the group field extends struct rte_fib_conf (40 to 48 bytes),
  so the ABI check of the CI will fail. Keep the field for 27.11, or
  add a FIB to a group with a new experimental call?
- IPv4 DIR24-8 only. The IPv6 trie embeds its TBL24 the same way and
  could follow.
- All the FIBs of a group use the same algorithm.
- The application must stop passing the dataplane pointer of a FIB
  before freeing it, as for its other RCU protected structures.

This series does not depend on the tbl8 pool RFC, sent separately.
Patches 1-2 (zero initialization of the FIB configs) are the same in
both RFCs. The two series touch the same place of dir24_8.c, so the
second one applied needs a rebase.

Maxime Leroy (5):
  app/graph: zero-initialize FIB config structs
  node: zero-initialize FIB config structs
  fib: add group of FIBs with bulk lookup across them
  app/test-fib: fix byte order of addresses read from file
  app/test-fib: add lookup across a group of FIBs

 app/graph/l3fwd.c                 |   4 +-
 app/test-fib/main.c               | 157 +++++++++++++++++++++-
 app/test/test_fib.c               | 216 ++++++++++++++++++++++++++++++
 doc/guides/prog_guide/fib_lib.rst |   6 +
 lib/fib/dir24_8.c                 |  70 ++++++++++
 lib/fib/dir24_8.h                 |  63 +++++++++
 lib/fib/dir24_8_avx512.c          |  82 ++++++++++++
 lib/fib/dir24_8_avx512.h          |  32 +++++
 lib/fib/rte_fib.c                 | 125 +++++++++++++++++
 lib/fib/rte_fib.h                 |  88 ++++++++++++
 lib/node/ip4_lookup_fib.c         |   2 +-
 lib/node/ip6_lookup_fib.c         |   2 +-
 12 files changed, 842 insertions(+), 5 deletions(-)

-- 
2.43.0

