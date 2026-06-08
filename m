Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70EE8CD8CA4
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Jun 2026 20:33:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 43C8140657;
	Mon,  8 Jun 2026 22:33:27 +0200 (CEST)
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170]) by mails.dpdk.org (Postfix) with ESMTP id 47564402AD
 for <dev@dpdk.org>; Mon,  8 Jun 2026 22:33:26 +0200 (CEST)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-306f36df4feso3088291eec.0
 for <dev@dpdk.org>; Mon, 08 Jun 2026 13:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780950805;
 x=1781555605; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IcsuCMYs38lY23E90dh5fttgKwmYUD4qtVTfjSsDin8=;
 b=ZoloRaBemdZx5Uv5/+yRp+RxjN2LNuqDI08yslP0LAGYPTxH4OoBcH7g3ZaZwliO7G
 C9UfiJINqTsLin+8pVeV4GDAQlkhQxvea7npYTqOhFkGD0y4dxAvaZoRWwPiIfEZ25Cz
 iCr93YWXhgtELzumQTgOMtddQhh55XR6F2L+N31i2ofJ32YVgk5HHSCFexQ624hVBC5A
 aXrDMA+qQiEBgyMopk4Mh7iN7llvG7FZ+u15JPkJqF2CcNldqkxIL26BhIKQqOt3yDZw
 rMpxyfmgpk00ilYnvbM08yTt3WNbE5uzpVVpex8gJcJvV9EkjeD8h2FsdlidjcKh/THs
 X34w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780950805; x=1781555605;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IcsuCMYs38lY23E90dh5fttgKwmYUD4qtVTfjSsDin8=;
 b=LoXu5I/mqXiFTVSw9UqB6ypvAN8aZbj2U3kZjoI005Qg4BYaQEpUqZcSGiJUDHjUHo
 s78PROeiASeWnmSbJG33qdz1efQyMPrGtlWN3geaTNQ8Ln1B7ZPcWDzaM/Z24CD8y4/Y
 QmEQ9Y/f4Brb4Xj2LHprxpUod1B4fC5NLsPs1k8oL0UbRWYzDWrsOEJA7jmF5Qgdzyoe
 QreZLfKGjJIp8FNKzLfigUZ+pYNa7VHLkzrE3738sa+XHs0Ew20879f2nl6NvFQJ6Nvm
 9P/0fBkRFdy9vbJkVnQRZrrEbSUJJ+aUbSsqgyyBt+0d/e/Jpcos7UjMV3xerQGFlGtq
 ITFA==
X-Gm-Message-State: AOJu0YxDTngAEcUtNrxW48l94rwPQgUhxCq9jpdpjVlvY9GCqqOD/B1f
 Fk4OGreF4D3EFGAJQ+9nFcLDX+lYEZfwMB/T0Jri78Onv45affidwFcLbfIcuB+3aI7CqFJ+bDG
 YJSeX
X-Gm-Gg: Acq92OHNXWv3+RJwvkcVJFm5ZD+A5QqmKXfj9J18GqaFtANkfhnx6PqVRmvqAZRKvdt
 AUlSwogBq6lfwYY7gjKBUhGwV028EtCRgny6d6rsyQiTCj6dE2Wcm7FubXbrz1Nd8wSQzDBbV7+
 GH871la5GhxV0JvopvsyJ7xZGTJX7s60n4LGurQx53Egpn2JasdbSk0VHovJWO1XNQhikH7eXto
 jJO78DsuzS2+F5HF7jJJ75q4uTxOLHINDn6FBtUFjjuZx4IXAS5/8BAar3mIr0ZlSQ2BQrr/m3r
 laXmMzMkZJ2DeoIbh+gYnRmaBLDyg4jYXv0SP02X0+ykrHT8qkCIENF21rhTZfB5eDfYmlihVuy
 acDL6h651PkUrPE4LuzFQx5/G3VPA+TPc79Yw43UO6c1irQamhI7p8NueR5PS8uOSmMs6NIpVu2
 swgg6rMBKYDkZqNn1W3QyMOeVD056fwCKHMsW0Wv2Lvn4hOTR8dNJDpm+ACGHbGRMTdRAjcG/9F
 3ibUs7p48s=
X-Received: by 2002:a05:7301:7c0e:b0:2e7:190:41d6 with SMTP id
 5a478bee46e88-3077fd752c9mr8339938eec.2.1780950804874; 
 Mon, 08 Jun 2026 13:33:24 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074db560d7sm25804178eec.5.2026.06.08.13.33.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 13:33:24 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 0/4] bpf/arm64: add BPF_ABS/BPF_IND packet load support
Date: Mon,  8 Jun 2026 13:28:46 -0700
Message-ID: <20260608203322.1116296-1-stephen@networkplumber.org>
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

Discovered this while exploring packet filtering.
The arm64 BPF JIT did not implement BPF_LD | BPF_ABS or BPF_LD | BPF_IND,
so cBPF filters converted by rte_bpf_convert() could not be JIT compiled
and silently fell back to the interpreter on arm64.

The first patch fixes a latent bug in emit_return_zero_if_src_zero():
the offset of the branch to the epilogue was held in an unsigned.
A backward branch wrapped around. Existing JIT tests were never
being run on ARM.

The next two patches make the bpf tests assert that,
on an architecture with a JITbackend, code is actually generated,
so a missing or failed JIT is reported rather than skipped.

The final patch adds the ABS/IND opcodes, mirroring the x86 JIT
with a fast path for data in the first
mbuf segment and a __rte_pktmbuf_read() slow path for the rest.


Stephen Hemminger (4):
  bpf/arm64: fix zero-return branch in multi-exit programs
  test: bpf check that JIT was generated
  test: bpf check that bpf_convert can be JIT'd
  bpf/arm64: add BPF_ABS/BPF_IND packet load support

 app/test/test_bpf.c     |  23 ++++++-
 lib/bpf/bpf_jit_arm64.c | 149 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 169 insertions(+), 3 deletions(-)

-- 
2.53.0

