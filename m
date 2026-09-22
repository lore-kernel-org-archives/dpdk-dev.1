Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C51C98302
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Sep 2026 16:26:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AF49342E7D;
	Tue, 22 Sep 2026 18:26:19 +0200 (CEST)
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by mails.dpdk.org (Postfix) with ESMTP id B33234278B
 for <dev@dpdk.org>; Tue, 22 Sep 2026 18:26:17 +0200 (CEST)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-39dbdfaef3cso84230a91.1
 for <dev@dpdk.org>; Tue, 22 Sep 2026 09:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790094377;
 x=1790699177; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5tMXLVL77KkLpaYFKfE/IVfX2Pdt9dHok3692Cx3jp8=;
 b=dLBWQIzD+Tw1bw0lxVqYUAP81uLbl3nJd3gnUJHRnZYMTeG7/oJb+qf8z/RgX708Ou
 oHDYJFadXHSkernpMbKyXZJtek80mugNW3QigYiHOjZgSK8wfttimBYH+Et0Z04YXhCe
 gbG/SwfC2/Jb7tTtKx8i4j0kGmViFTFOvDvMnbPUEek2a7cO24xKf0rVVSrpijc1ylmg
 ga2nw/L7DkeYyzHE9WIFFJuoxf+kYQqNGqkhyoOdSWhfyAgwjqJzOsVjTFWespUdO/u8
 X4faoTjXmHTUJEAWLCHhGyAP5I2RBReck8beLmGGDhNlm2tWTsFp+L7umxXP6O2Mu0v4
 JRyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790094377; x=1790699177;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5tMXLVL77KkLpaYFKfE/IVfX2Pdt9dHok3692Cx3jp8=;
 b=WkPfSAZoZhjv1nyZ+qDvoXU2SsF78lTV5/IWWX35ZY7/DupkeaoIG0SCmqioxOgjJL
 Ta8jolZUygepzer76aCp+lgNZvQJQoPOZb7/YjMSKjr46Cp/Ft8A8Bslm64P0s4dsEdS
 LqRvDuxcgKrHo+YqY7rEbfJs7DCIY+9hw+SZsQqToBqA2upBtxrfUBK6AyR0TUklnv83
 TaZG5ZjKAzCWZwfJY5F6M8UITGDX8Lis1EYLz5Xn4sXbo2c1kYlKxG4Rq0AdY7Z4ikfX
 0wlXgqCPhTelsccxONNsnc3WDEvolTV2JFdc0rfdE1NOSeyVXqjpY0OEyZX52QCwQwwq
 bn8A==
X-Gm-Message-State: AFuF++mbY3rPIYPm44RUod2Z1zzLVoJaZzXlm/tOAdnsCuyYWLfExMVI
 VXacizxGLCsy3j7NgNv2bDLjXd7IVhTGdEyRIsye8vz5bKWR65WiMvBN5k6z5d2DFAU=
X-Gm-Gg: AYBFou0XBDaImmI7JsI+teAxj+gf4E+v/rgG1HOl+eXKRIJ3enfZbqcglFJAizy22o4
 YU90eAVMBb+f7ExibAZkrWRktsMSPfixbB9U1WCkpfBGwyRQrHD/RSzEiMquCxTRDWJG0uDTb+d
 EuzjCs2OLY/sqPRwYCVqTY5V21atAbSFbGtYR9BwiDbxUo+McUAIwGexpcFT6+GVoNfoaYTOQxO
 KbeA23G/v1k0qpmS+FZ5a+8qCgVItUKASnV1aNJOK6kXeeY3I2wYrVMwKwUGETS/lVsixbVgkep
 7013D82qGCFXkdaFK407oyV0hFDLTNB6ydZgIPM+2IoNMHzoRB1FNGMBMk2KSr6E0s4fSs0Ne0p
 H6XEKAYIuQiw3fX8+u0tnu3Pb+mMYZ2vfohYN1s31YtF44bi9f/uArwmJIEGlRxl6YN8TZpaq62
 gJ7V+ivuKYGxPM5dFj8OMsAynwiw4yHlxOFwRMUEPA9hCxuSkeR8Z/u+1WW8hDhwL9GxoCSO9OW
 m70sZ/KOIzQk4p6OG9ICWmyeFwqp+DyLvA3A4AY
X-Received: by 2002:a17:90b:35c3:b0:39e:6c69:7770 with SMTP id
 98e67ed59e1d1-3a07321f254mr1896430a91.25.1790094376807; 
 Tue, 22 Sep 2026 09:26:16 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a07ddf01e8sm132855a91.8.2026.09.22.09.26.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 09:26:16 -0700 (PDT)
Date: Tue, 22 Sep 2026 09:26:14 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Kai Ji <kai.ji@intel.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>
Subject: Re: [PATCH v5] examples: add Wycheproof validation app
Message-ID: <20260922092614.3c9aacf9@phoenix.local>
In-Reply-To: <20260922160557.2789446-1-kai.ji@intel.com>
References: <20260922144718.2776346-1-kai.ji@intel.com>
 <20260922160557.2789446-1-kai.ji@intel.com>
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

On Tue, 22 Sep 2026 16:05:57 +0000
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

AI review had some useful suggestions on this.

Wycheproof validation example (v5) - review

v4 -> v5 delta: drop unused APP_NAME, close the device on the
app_init() error path, and treat asym session-create failure as
-ENOTSUP (skip) instead of -EIO/-ENOMEM (fail) in run_dsa_verify(),
run_ecdh_ecpoint() and run_ecdsa_verify().

Applied on 6bbb7b3, built with -Dwerror=true, docutils clean. Same
crypto_openssl runs as v4: directory run passed=1902 failed=0,
--mbuf-dataroom 160 and --cryptodev-id 256 behave as in v4.

No Errors or Warnings.

Info
----

main.c:1222, 1480, 1715
    ret = -ENOTSUP;
  Session-create failure is now indistinguishable from an unsupported
  curve or key size: a PMD that advertises the xform but fails
  session setup for a curve it claims to support, or a -ENOMEM from
  an exhausted asym session pool, lands in skipped_capability and the
  exit status stays zero. Understood that the asym capability struct
  does not enumerate curves, so this is a documented trade-off; just
  noting that valid asym vectors can no longer fail at session setup.

main.c:823-824, 837, 957, 1047 (open since v3)
    memcmp(output, vector->ct, vector->ct_len) != 0
  memcmp(NULL, NULL, 0) for empty-message vectors; glibc declares
  memcmp nonnull. Guard with len != 0 &&.

main.c:182-183, 266 (open since v3)
  Positional struct initializers; use designated members.

doc/guides/sample_app_ug/wycheproof_validation.rst (open since v3)
  crypto_openssl advertises no ECDSA/ECDH xform capability, so the
  documented command line skips every ECDSA/ECDH vector. One sentence
  saying asymmetric coverage needs a PMD advertising those xforms.

Pre-existing, not introduced by this patch
  lib/cryptodev/rte_cryptodev.c:2411 rte_cryptodev_asym_session_create()
    ret = dev->dev_ops->asym_session_configure(dev, xforms, sess);
    if (ret < 0) {
        ...
        return ret;
    }
  On configure failure the object stays allocated from the pool and
  *session still points at it, unlike the sym variant which does
  rte_mempool_put() on its error_exit path. This app copes by freeing
  a non-NULL session at out: even when create returned an error; if
  the library is ever aligned with the sym behaviour that becomes a
  double put. One for the cryptodev maintainers, not this patch.

Review-Result: CLEAN
