Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B636C982E6
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 16:41:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BE38E42D9F;
	Mon, 21 Sep 2026 18:41:23 +0200 (CEST)
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by mails.dpdk.org (Postfix) with ESMTP id 49DFE40E2B
 for <dev@dpdk.org>; Mon, 21 Sep 2026 18:41:23 +0200 (CEST)
Received: by mail-pj2-f13.google.com with SMTP id
 d9443c01a7336-2d747ee1f9bso27710905ad.3
 for <dev@dpdk.org>; Mon, 21 Sep 2026 09:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790008882;
 x=1790613682; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Jt+RH2TGU25NuFXA1BrhZnjeYLH+DmHoNb4aVKaJf00=;
 b=NPySwbpZwEicNdwrLWlzMmMjXGif2fNNmHYJrSzZTUUqJDcH+FzDNvFVDsTF0mJxgj
 H+jTuf+1nowEQAooCk/B0CRXHzDMd8Hcmv2kCuytmPPVvva6yUq12cfCU5T3LGPWx5fn
 bcd3gakAvPH4tfvjOGDtJF40uogXiDTDjxF31sDbSJnRNldHtIvGJcC0b28nFInnIJqS
 eSKzIpHbQAm+JxN/aSlFMWbErdcUE0gvIj4VvcdyTTLWmfU0rd4auzf3z0n/7+Jzw5QG
 DF/GgzcQBSKd3ZP8CtDpUGPl0Z3S88sGbXBmI38dmGtbDBJankyfpSR50d4OeQbVQQnR
 8K0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790008882; x=1790613682;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Jt+RH2TGU25NuFXA1BrhZnjeYLH+DmHoNb4aVKaJf00=;
 b=loAFjTlARL/37f4RJnzAa+X/oB/Z7YYW3lC1XpbC3x8EG8Rebip749RcVxSXVZPaIw
 mOaju+KJSCqrNSoV5lDP+SljTKyJoAaRft1HD6EfQJ/tsOuxkT7mcSUmjm1ECQwq2PwW
 L/V+IERlREC+pQbeq93E5oFz0T5j0eyyzBcw5tcEhbxCpbB3vH5TmpM1uTt57pLwzUpf
 1RMOmlsh42TqB/jNsEmVaW8irxSuX7hdn3GLgCncVLjhcathYXIvjwhl1JGe0LG3bHH5
 9iu1ArUyaMoI22QFUz4tOYzO5DqKCGic7r8F6vy/q9aw5XEHk6suvYD/3U6/J9EhNISr
 ZCGA==
X-Gm-Message-State: AFuF++kbHEnNicpAeZIYmkhNYneLywcbaiyB90h7WjbeICwYdtErgu+n
 dW2yl4W0VkhKby0olqrLw8KGLR02NAR0/iuJbKrhOX0gNmSbwmPFuOQRXFjLrBHmTWM=
X-Gm-Gg: AYBFou2LYgg276weqohRzG9FF0RFKWvIx6LnU4a06goBbmTCy2QJtwBv0ZNVmDSeNEO
 6sm5Dqlfru8b5c6poy/To8TrfLzKgkGY3kZYm8vE82UdgR35gS4efwR1P14AvSTzpPK+Z5VC8BY
 6v6cn2YBZ6LcBs9PUaPlgANbIykQXQ18CKpmwP7W3Nlh1U3AelJJH/vRCLorjaT0B11ZAB4bhm8
 i8mbX8+qjrYfN2jZBl/kHh4PG7f/E9nCiQgH93kR9V6wBE7nXpnHdWelidKt+klsf/rCfwA6NV1
 9y2Ouy8I+Yfmv2T1g69MzeQ87MzE8pODyK6CvdmHCI6HUbxT4oDZt0cgPqhd/9hLiD6UAniVVTq
 QZOCbuIbbsYnYC93gLdlKaLSo/6LVd5c233hiHNjNX9FGiBZmH9zdQQ81zvKt+yavCmFp1twgqG
 LQzVH4oxrWz+rC5Pzru9nwSkAvimBsdkjvzIPuLtHtnCCXYLJ7XOh1QzVFayEUU1XQzoRr9BRQR
 UFmiQQ2CxfyWfdJF8chu5v3NO82RdHLxzw7AB0CLQ==
X-Received: by 2002:a17:903:46c6:b0:2dd:ad73:5b67 with SMTP id
 d9443c01a7336-2ddb1c196d2mr165413715ad.23.1790008882242; 
 Mon, 21 Sep 2026 09:41:22 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2df475fd335sm18883705ad.2.2026.09.21.09.41.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 09:41:22 -0700 (PDT)
Date: Mon, 21 Sep 2026 09:41:20 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Kai Ji <kai.ji@intel.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>
Subject: Re: [PATCH v3] examples: add Wycheproof validation app
Message-ID: <20260921094120.53bea0af@phoenix.local>
In-Reply-To: <20260917153420.2609071-1-kai.ji@intel.com>
References: <20260915155157.2446094-1-kai.ji@intel.com>
 <20260917153420.2609071-1-kai.ji@intel.com>
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

On Thu, 17 Sep 2026 15:34:19 +0000
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

Wycheproof validation example (v3) - review

Applied on 6bbb7b3, built with -Dwerror=true, ran against
crypto_openssl on 12 Wycheproof v1 files (GCM, CCM, ChaCha20-Poly1305,
HMAC-SHA1/256, CMAC, GMAC, DSA, ECDSA, ECDH). No validation failures
on supported vectors.

Errors
------

doc/guides/sample_app_ug/wycheproof_validation.rst:5
  Title underline is 28 characters under a 29-character title:
    Wycheproof Validation Example
    ============================
  docutils reports "Title underline too short"; doc/guides/meson.build
  adds -W under -Dwerror, so the doc build fails. Add one '='.

Warnings
--------

main.c:790-792 validate_aead_vector()
    vector->msg_len > env.mbuf_data_room
  Usable room in a fresh mbuf is data_room - RTE_PKTMBUF_HEADROOM.
  A message inside that 128-byte window passes this check, run_aead()
  returns -EMSGSIZE at line 536, and line 806 (ret != 0) counts it as
  a validation failure, so the exit status is nonzero. Verified:
  --mbuf-dataroom 160 on aes_gcm_test.json gives failed=54, all
  ret=-90. run_hmac(), run_gmac() and compute_hash() have no
  pre-check at all and misclassify the same way (--mbuf-dataroom 128
  on hmac_sha256_test.json: failed=110). Compare against
  env.mbuf_data_room - RTE_PKTMBUF_HEADROOM and map -EMSGSIZE to
  skipped_unsupported in every caller.

main.c:148-151 parse_args()
    if (parse_uint32(optarg, &value) != 0 ||
            !rte_cryptodev_is_valid_dev(value))
    env.dev_id = value;
  rte_cryptodev_is_valid_dev() takes uint8_t; value is truncated
  before the validity check and again on assignment. Verified:
  --cryptodev-id 256 silently runs on device 0 while --cryptodev-id 1
  is correctly rejected. Reject value > UINT8_MAX (or
  >= RTE_CRYPTO_MAX_DEVS) before the call.

main.c:577-580 run_aead(), and the same pattern at 751, 1108, 1190,
1440, 1667
    completed = dequeue_one(env.dev_id);
    if (completed == NULL) {
        ret = -ETIMEDOUT;
        goto out;
    }
  On timeout the op, mbuf, digest/aad buffers and session are freed
  at out: while the enqueued op is still owned by the PMD, then the
  tool moves on to the next vector. A hardware PMD (QAT is named as
  the target) completes into freed memory, and the next dequeue_one()
  can hand back the stale op as the current vector's result. Treat
  -ETIMEDOUT as fatal: propagate it to main() and stop, rather than
  free and continue.

Info
----

main.c:807-808, 817, 918, 998
    memcmp(output, vector->ct, vector->ct_len) != 0
  When msg_len/ct_len is 0, run_aead() leaves *output NULL and
  decode_hex() leaves the vector buffer NULL, so this is
  memcmp(NULL, NULL, 0). Wycheproof has many empty-message vectors.
  glibc declares memcmp nonnull; -fsanitize=nonnull-attribute trips
  on it. Guard with len != 0 &&.

MAINTAINERS:2038
  "Other Example Applications" is alphabetical; the new entry sits
  between FIPS and Flow filtering. Move it after "VMDq examples".

main.c:180
    struct rte_cryptodev_config config = { rte_socket_id(), 1, 0 };
  Positional initializer; use .socket_id/.nb_queue_pairs/.ff_disable.

doc/guides/sample_app_ug/wycheproof_validation.rst
  The documented crypto_openssl PMD advertises no ECDSA or ECDH xform
  capability (rte_openssl_pmd_ops.c capability table), so with the
  documented command line every ECDSA/ECDH vector lands in
  skipped_capability (verified: 0 passed, 241 skipped on
  ecdsa_secp256r1_sha256_p1363_test.json). Worth a sentence that
  asymmetric coverage needs a PMD advertising those xforms.

Review-Result: ERROR
