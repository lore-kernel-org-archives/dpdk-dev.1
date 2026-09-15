Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E63C88E7D
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 18:29:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6E8C74025F;
	Tue, 15 Sep 2026 20:29:47 +0200 (CEST)
Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com
 [74.125.228.43]) by mails.dpdk.org (Postfix) with ESMTP id CDE494003C
 for <dev@dpdk.org>; Tue, 15 Sep 2026 20:29:46 +0200 (CEST)
Received: by mail-pz2-f43.google.com with SMTP id
 d2e1a72fcca58-868a9c48f9eso25100b3a.3
 for <dev@dpdk.org>; Tue, 15 Sep 2026 11:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789496986;
 x=1790101786; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MS7R2Q188RYu8YNP4RtlhNLtq2xm2dLh1VhpZyA0LCc=;
 b=Zx013Bo6n70XOCUk3+J2pI7aGSfSiaIQmZQwCGfBaUxFcxSUmh9E5XBwkZ/2t5T0vA
 9RW+Wo3zKJxLMVyOMNLBkw7vT6SXTEAwbtjl11O3AfX+YuZihuJgLRHyXPl4Se7MgjLk
 1wLE/FM0GyzvPHhPcPeUoAVmvrgpi3f3i9Z9U4sZ+5IF7VUNPO6TKM+0Gc6Z28I7Q2eD
 aYvsYkwYooG8ykECfZgRe/fjAwzTW6FrJ12a5R0r0g+yhVNlSmx+aT8WDLKi/CBksu+g
 tx8ZqBPb9jAF1rmHkcxUyThrEIxoo1Ek5mRD7do50aaWHDttfra2BFfXguTjdA9riYKI
 O1BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789496986; x=1790101786;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MS7R2Q188RYu8YNP4RtlhNLtq2xm2dLh1VhpZyA0LCc=;
 b=BCX+yXlLRGfuJZcYjgkYDj1cXe0ZS/9UUo98iysZB7TH3JPmur/CgpOyp3BHD/E+JI
 a386j5wiIimFnU1/Aq4QrJcquaqIo1eMKlnyBQ+ApoF2LVOtbVvjA+IqWPphodITXSpr
 mvadrBgzp214Jt/Vs2KrT6UCKhL8sfhkefyyFdHXi11kTub3Opi2BDLtQ2pWZVH9mt0D
 nlT3UWTD59cCLlaA1MI5JoFMPBxZejGb5a3k/Cc/8VeES/8QbIcjxnnfSCEAV90gfUbE
 VV/ApHYv9XCuXMNd6B8si+K/HhuoMknwikKyRrCFvH14AuCYc85mqS7inVL/e1rsp2MB
 Zptw==
X-Gm-Message-State: AFuF++lCv8/EVyTSRxUkrcbuVxgBwrqazZI7DE22ZcJU+wz7rpZZP1f7
 YzeyNPpa+2ADim9vnGEXG/9aaqF5D1po5vXwajPOKHgMyfKiW6bTlbpzHXDUuVHkRcY=
X-Gm-Gg: AYBFou2OpcA22uwhJFfM1jQoisNFp3+PIWm6MDLsDk/ALg4CVian1g0z5jOfg6iAFqW
 BxvnnDoa1/+oLa2yqzrJBMO94GRlJjKS4ePMoPpFOC/e8uk6fDwoGQcIM66xc+urmGwdE6qsXVL
 cG9m4XedrJ8luzJREo107Cawc6VyddCdYVC4d9S/ZLmy1y//0rE2xuQe74jPNTchlkBnMXVCaf0
 7oKDzmhNGXpxn71TAXop+U8GDzQhYEmSYT7jYFplIVkByiZeX+7vHxb0/NPP5Jc5eRYUQFgT+sn
 C9FTqzWO4L6mE1vRJUxNRNHOjouFSHHdfJR70mSl6kxCcuFG1hTckUDQNdJY+4RlGBZNS1Amblu
 vwywY1+VVi0pIJgt/MOEw5rDa/zbsb/MnThyKWdp0BdFUB8mX/xZPN0Lcnrb6kObLSyBoCD2HHs
 gPcOIAazlWoPbzYRP4aX+ZZvo7bdvxJcxqyKXg8psPri+NhLUstL9HZ0JmkDMTPmo0hlt7ktvQ3
 mX+Lz18JIYXMAFFkt77mA3dgs8SYofzWOWHT1a+wI44sB0HCzUw
X-Received: by 2002:a05:6a00:181c:b0:868:c090:e5f0 with SMTP id
 d2e1a72fcca58-8717eed005bmr4105755b3a.8.1789496985684; 
 Tue, 15 Sep 2026 11:29:45 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-871febdd0e5sm61331b3a.4.2026.09.15.11.29.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 11:29:44 -0700 (PDT)
Date: Tue, 15 Sep 2026 11:28:46 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Kai Ji <kai.ji@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] examples: add Wycheproof validation app
Message-ID: <20260915112846.1aa6cd41@phoenix.local>
In-Reply-To: <20260915155157.2446094-1-kai.ji@intel.com>
References: <20260915155157.2446094-1-kai.ji@intel.com>
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

On Tue, 15 Sep 2026 15:51:57 +0000
Kai Ji <kai.ji@intel.com> wrote:

> Add a Wycheproof JSON vector validation example for cryptodev PMDs.
> 
> Support these algorithms when advertised by the selected PMD:
> - AEAD: AES-GCM, AES-CCM, SM4-GCM, ChaCha20-Poly1305
> - MAC: AES-CMAC, AES-GMAC, HMAC SHA-1/SHA-2/SHA-3/SM3
> - Asymmetric: DSA (P1363 verify), ECDSA (P1363 verify),
>   ECDH (ecpoint shared-secret compute)
> 
> Validate valid vectors against generated ciphertexts, tags, plaintexts,
> digests, shared secrets, or signature verification, and require the
> expected rejection for invalid vectors. Digest inputs for DSA and ECDSA
> use the symmetric auth path, selecting a separate symmetric-capable
> device when the target device is asymmetric-only.
> 
> Skip parameter combinations outside PMD capability ranges and identify
> recognized vector families without a compatible DPDK transform. A
> --debug option lists every failed or skipped vector.
> 
> Add Meson and standalone build integration, with usage documentation.
> 
> Signed-off-by: Kai Ji <kai.ji@intel.com>
> ---

Fable found lots of issues that need addressing.

Review: [PATCH] examples: add Wycheproof validation app

Built with meson -Dwerror=true, gcc 13.3, crypto/openssl. Ran the app
against Wycheproof v1 vectors (GCM, CCM, GMAC, HMAC, CMAC, DSA) with
crypto_openssl after fixing the build error below; those pass.

Errors
------

1. Build fails with -Dwerror (test-meson-builds.sh default):

   main.c:954,957: 'status' may be used uninitialized
   main.c:1194:    'status' may be used uninitialized

   process_gmac (decl line 929) and process_dsa_p1363 (line 1194)
   leave status uninitialized on the -ENOTSUP and non-valid/invalid
   paths. validate_aead_vector (decl line 740) has a real read: a
   non-zero ret from run_aead jumps to failed: and line 795 prints
   status. Initialize to RTE_CRYPTO_OP_STATUS_ERROR in all four
   places, as process_ecdh_ecpoint and process_ecdsa_p1363 already do.

2. CCM AAD buffer is too small, heap overflow on QAT (line 526):

       aad = rte_zmalloc(NULL, vector->aad_len + 18, 0);

   rte_crypto_sym.h (aad_length) requires the 18-byte prefix plus
   padding so the allocation is a multiple of 16, and says PMDs may
   write the padding. QAT does: qat_crypto_pmd_gens.h ~1194-1206
   memsets &aad_data[18 + aad_len] for 16 - (aad_len + 2) % 16 bytes.
   Every CCM vector with (aad_len + 2) % 16 != 0 (Wycheproof aad
   lengths 0, 1, 2, 7, 8, 15, 16, 17, ...) writes past the buffer.
   app/test uses RTE_ALIGN_CEIL(aad_len + 18, 16); do the same.

   The guard on the next line is also wrong:

       if (aad == NULL && vector->aad_len != 0)

   The allocation is never zero-size, so a NULL here means the PMD
   writes B0 and the flags byte through a NULL aad.data. Use
   if (aad == NULL).

Warnings
--------

3. EC operands passed at JSON width (lines 1548-1551, 1327, 1354):

       xform.ec.q.x.length = group->wx_len;
       xform.ec.pkey.length = priv_len;

   Wycheproof encodes wx, wy and private as signed-style big integers:
   in ecdsa_secp256r1_sha256_p1363_test.json most groups have a
   33-byte wx or wy (leading 0x00), some 29 bytes; secp521r1 groups
   range 62-66; ecdh private lengths are 1, 29, 32, 33. QAT, which the
   README names for ECDSA/ECDH, packs with SET_PKE_LN/SET_PKE_9A_IN as
   buf + alignsize - length with no length check
   (drivers/crypto/qat/asym/qat_asym.c:81-96); a 33-byte value writes
   its 0x00 one byte before the slot, into the neighbouring operand.
   Result is wrong verifications, not skips. Normalize to bytesize:
   strip leading zeros (value_equals_padded already does this), reject
   anything still longer than bytesize, left-pad into a fixed buffer.
   DSA p/q/g/y have the same encoding (a 2048-bit p is 257 bytes);
   only crypto_openssl implements DSA today so it is tolerated there.

4. IV copied into the op with no bound (lines 533, 538, 711):

       memcpy(rte_crypto_op_ctod_offset(op, uint8_t *, IV_OFFSET),
              vector->iv, vector->iv_len);

   The only guard is the PMD's advertised iv_size range. mvsam
   advertises AES-GMAC iv_size max 65532 (rte_mrvl_pmd_ops.c:371);
   aes_gcm_test.json and aes_ccm_test.json carry 257 and 268-byte
   IVs. The room after IV_OFFSET is 152 bytes, and only because
   priv_size at line 210 is IV_OFFSET + 64: priv_size is already
   relative to the end of the sym op (rte_crypto_op_pool_create adds
   sizeof(op) + sizeof(sym_op)), so IV_OFFSET is counted twice.
   Define an IV maximum, use it as priv_size, and skip vectors whose
   iv_len (+1 for CCM) exceeds it.

5. mbuf pool sizing (line 181):

       sizeof(struct rte_mbuf) + RTE_PKTMBUF_HEADROOM +
       env.mbuf_data_room

   data_room_size already excludes the mbuf struct; this wastes 128
   bytes per mbuf. The parameter is uint16_t and --mbuf-dataroom is
   only checked for != 0, so large values truncate silently and
   values below RTE_PKTMBUF_HEADROOM wrap the check at line 754
   (env.mbuf_data_room - RTE_PKTMBUF_HEADROOM). Drop the sizeof and
   range-check the option.

6. PMD failures on valid vectors counted as skips (lines 1473-1476):

       } else {
           stats->skipped_capability++;
           debug_vector("SKIP", name, &vector, "PMD could not compute");

   A valid ECDH vector where the op returns an error exits 0.
   run_ecdh_ecpoint and run_ecdsa_verify also turn asym session
   create failure into -ENOTSUP (lines 1341, 1556) while
   run_dsa_verify returns -ENOMEM and fails the vector. Capability
   skips should come only from the capability query; anything the
   PMD rejects after that is a failure for a validation tool.

7. Documentation and MAINTAINERS. Examples are documented in
   doc/guides/sample_app_ug/<name>.rst and listed in index.rst (see
   fips_validation); README.md is not the convention (only
   examples/bpf/README exists). Add the rst and a MAINTAINERS entry
   with F: examples/wycheproof_validation/ and the rst, as
   fips_validation has.

8. Makefile has no trailing newline (checkpatch warns).

Info
----

9. process_file is a 20-arm strcmp chain re-testing algorithm and
   schema in every arm. A static table {algorithm, schema, kind,
   algo id} and a loop replaces it.

10. decode_hex uses rte_malloc for every field. Only the AAD (the
    GCM/ChaCha path hands vector->aad to the PMD directly) and the
    digest buffers need IOVA memory; keys, messages, signatures and
    DSA/EC parameters are copied by the library or PMD. If the AAD is
    always copied into a 16-byte-padded rte_malloc buffer (fix 2
    does this for CCM), decode_hex can use plain malloc.

11. Every dequeue loop (549, 637, 717, 1064, 1143, 1363, 1574) spins
    forever if the PMD never returns the op. A bounded wait that
    fails the vector is better for a tool meant to run on hardware.

12. Symbols used without a direct include: bool (<stdbool.h>),
    PRIu64 (<inttypes.h>), strtoul/EXIT_* (<stdlib.h>), PATH_MAX
    (<limits.h>). All come in transitively today.

13. Placement: this is a conformance tool with an exit-code contract,
    not a sample showing API use. app/ next to dpdk-test-crypto-perf
    is the more natural home.

14. Pre-existing, not introduced by this patch: QAT SET_PKE_LN and
    SET_PKE_9A_IN (qat_asym.c:81-96) never check length <= alignsize,
    so an oversize rte_crypto_uint writes before its slot. Worth a
    separate fix in the PMD.

Review-Result: ERROR
