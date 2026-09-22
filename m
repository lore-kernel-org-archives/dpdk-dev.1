Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3632FC982FA
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Sep 2026 19:41:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 23A8940281;
	Tue, 22 Sep 2026 21:41:43 +0200 (CEST)
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12]) by mails.dpdk.org (Postfix) with ESMTP id 17F8640041
 for <dev@dpdk.org>; Tue, 22 Sep 2026 21:41:41 +0200 (CEST)
Received: by mail-pz2-f12.google.com with SMTP id
 41be03b00d2f7-cc4bdf8abaaso264628a12.2
 for <dev@dpdk.org>; Tue, 22 Sep 2026 12:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790106101;
 x=1790710901; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZTIA+lncDumISXoJX8s8Mtm5sQQi39P2RhUyAG5+IvM=;
 b=LcSe8FeYXvPuK5RuRgY5yAaAv5Z9JqTmsOQaPli6BxjN4GKCokVCNCtU9pCmrXnc2R
 WH9bwshbTcO2uNv0x61EcmRPeqePkcaVaJIdw+GjjUzlK8pBiqxyWSH8gttS8ugYHwg8
 L/8bk1mYorTaSQ14IN2M0BcyeVOWyWY+lA6gd3CagDtzOvzm0WJj7Ue68xYudGPliMqu
 YCSCyiww8Iyefew0w6uELAJVQHqkyKz+vaZHMERcAs8RHxlPGwtuB68nriDXKR7Mxoeh
 md/VBkBuYchitTFWgB9k8Do1KfK7PsjeOneqYsYoweGGkU0olB5x1YThvolFIaz+CY0k
 afqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790106101; x=1790710901;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZTIA+lncDumISXoJX8s8Mtm5sQQi39P2RhUyAG5+IvM=;
 b=RhlBBHfUVssmNfruk5bBxmVIxPlD6vLGbK3MFCSYNMZ9AfH0wTpFe6MF1TVIQdPGxC
 DJry5NAf80NT8/Er0izlKLu4N9slCCMwA3BitZbLEAzLovemlnELdocEgzXJpRgVnJgu
 43P620Y1qUESalQyx15nyTedViZ5133u4ZAi+BJEa6Md6ugsS5rrjZajsY962/MzCGxq
 LAb/zvR1BS5pquamEdxFyk99lZlqP4EH1avBmWVobraZxyvI/GS/LSW0AHYgDyQRANG2
 TPisK2PSxO8//2jEL4Oh9LEMcmtxDMAvIrVlEC4a6VytXRKhBqb70KLLDhyUucShtxZj
 j4zg==
X-Gm-Message-State: AFuF++nmuVts2AIlJQbNIV5ES2wusFyuNciVgjtiuzm7QGL8KnREVTlK
 NoWiyj3yB4r3bIAxsIiIcU046GJ8yZTM7e2YVQBbGAoJr1O/zkrNQJyEOw27jVKBJ/vEgNlZyzB
 NdcwEHIo=
X-Gm-Gg: AYBFou26FhhvJdNVt2YXtX815R+t4sWXiGCvC47kZw+4ljinCwXEMApcb5TYxAuM+9v
 VEuNUpHRf2pn7w+6ACRYWgeoWXHb7gBiJw0WfP/UWhjeHlSOrD73Ll1jNSv/sVGdBwDd9kljg9G
 EWaSGFNJ0y391KdKiyF9RoM/gf0AAW9qmszwTUL0b1pk2eisqCUmDJYZ3yGAMLI7Iinb2l0ws5G
 7c6u/Xb4RIoCQmQnXboLX+CbVUc7KkTUkxBYr+JjazyfqaGNkgp6JyyEi2tNdhwLtH9GjPiHY3n
 mQ09+zfmlQ81wAmCR4l6S0m7lCVRfhNwkw6IMdDoTcteFwDrnSCKemTtpj0cI4XYAIA44q7KJqk
 /2GRRq7NFGnAP/jjyK06Io5YX+g1g7DltlM8vRco87wupC3duSAiM9HqFXWMUw7agVvdA6NlFQJ
 DigZ9xv+Fa8Nqh8gKECJbFveqQEXgSpJonL+N1ZaHy2XHTpqX3u1xV4HD722Nz6ETHv4Z9HxJzB
 fhuo5hQefN5u68zwQoUfC3xVKV9Ub0O3ktoDQ==
X-Received: by 2002:a17:90b:3dc4:b0:39e:53a:c8d4 with SMTP id
 98e67ed59e1d1-3a07e517e1dmr363851a91.12.1790106100582; 
 Tue, 22 Sep 2026 12:41:40 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a07ddf1cf3sm814881a91.9.2026.09.22.12.41.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 12:41:40 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Arthur Chan <arthur.chan@adalogics.com>
Subject: [PATCH 0/7] net/memif: validate input from connecting peer
Date: Tue, 22 Sep 2026 12:40:51 -0700
Message-ID: <20260922194138.508919-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

A fuzzing effort by Arthur Chan turned up a number of ways for a memif
client to upset a memif server. Taken together they are not isolated
bugs so much as one systematic gap, which this series addresses.

memif is asymmetric. On connect the server hands its region file
descriptors to the peer, so a client can reasonably trust the server it
connected to, but the server cannot trust the client. The shared rings
and their descriptors stay writable by the peer for the life of the
connection, and control channel messages arrive before anything has been
validated. The driver was written as if both ends were cooperative: it
turned client-supplied region sizes, ring geometry and buffer
descriptors into pointers and lengths without checking them. That is
what the fuzzer found, from several directions.

Patches 3 to 5 do the validation (Bugzilla 2010, 2011, 2012, 2013, 2018,
2019) and are marked for stable, as is the statistics fix in patch 2.
Patch 6 adds a two-process testpmd connectivity test, which is also the
harness an adversarial peer can be driven from. Patches 1, 2 and 7 are
unrelated to the fuzzing and bundled because they touch the same driver.

The PMD has effectively been unmaintained for some time, which is why
these have sat. A call for a new maintainer went out and Sriram
Yagnaraman has volunteered; he has reviewed and tested this series.

Interoperability
----------------

These checks were written against the VPP plugin and libmemif so that a
hardened DPDK server does not disconnect conforming clients. Two are
deliberately looser than they could be:

  - A missing F_SEAL_SHRINK on a region is a warning, not a rejection.
    libmemif seals region 0, but hugepage-backed regions cannot be
    sealed, and a memfd created without MFD_ALLOW_SEALING is
    indistinguishable from one whose owner chose not to seal. The fstat
    size check covers the same ground without breaking those clients.

  - Ring offsets are only required to be 8-byte aligned, though
    implementations use 64 in practice, to avoid rejecting small-ring
    setups.

If anyone knows of a stricter guarantee that can be relied on here, I
would rather tighten these.

Not fixed here
--------------

Some reports need agreement on the wire protocol rather than a local fix:

  - Bugzilla 2014: hello advertises the driver-wide maximum ring count
    rather than the device's configured count. The obvious one-line fix
    does not work: hello is built from the control channel alone, and the
    device is not associated with it until init, which arrives after
    hello has been sent. This means changing when ring counts are
    negotiated.

  - Bugzilla 2015: ring semantics differ from the VPP implementation.

  - Bugzilla 2017: the trust model and the normative requirements for a
    conforming client are not written down anywhere. That amounts to
    specifying the protocol, better done with a maintainer to agree it.

Three more pre-existing ways for a client to upset a server turned up
while writing this. All are structural rather than local, so they are
listed here rather than tacked onto the end of the series:

  - memif_disconnect() unmaps the regions while the data path may still
    be inside a burst function. The burst functions test the connected
    flag only on entry, so a client that disconnects under load can
    already fault the server. Fixing it means waiting for lcores to leave
    the burst functions, or deferring the unmap to a quiescent point.

  - Control messages are dispatched on type alone, with no check of role
    or connection state. A client that sends init then hello makes the
    server run the client-only setup path. This wants an accept table by
    role and state in memif_msg_receive().

  - Queues the client does not add keep the ring geometry from the
    previous connection: disconnect does not reset it and connect only
    walks the negotiated ring counts. An offset validated against the old
    region can then be used against a new, smaller one. Ties into 2014.

One limitation within the series: a secondary process that sees a bad
descriptor counts the error but cannot tear the connection down, since
only the primary owns the control channel. That needs an mp message.

Reported-by: Arthur Chan <arthur.chan@adalogics.com>

Stephen Hemminger (7):
  maintainers: update for memif driver
  net/memif: fix issues in statistics
  net/memif: validate peer descriptors
  net/memif: validate control channel requests
  net/memif: validate descriptor length in zero-copy mode
  net/memif: add server/client connectivity test
  doc: clarify memif secret is not access control

 .ci/linux-build.sh                |   1 +
 .mailmap                          |   1 +
 MAINTAINERS                       |   2 +
 devtools/test-memif.sh            | 169 +++++++++++++
 doc/guides/nics/memif.rst         |  20 +-
 drivers/net/memif/memif_socket.c  | 129 ++++++++--
 drivers/net/memif/rte_eth_memif.c | 397 +++++++++++++++++++++++++-----
 drivers/net/memif/rte_eth_memif.h |   1 +
 8 files changed, 635 insertions(+), 85 deletions(-)
 create mode 100755 devtools/test-memif.sh

-- 
2.53.0

