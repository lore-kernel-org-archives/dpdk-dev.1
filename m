Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D65BC9832A
	for <dpdk-dev@archiver.kernel.org>; Sat, 26 Sep 2026 16:51:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C4068402A4;
	Sat, 26 Sep 2026 18:51:48 +0200 (CEST)
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by mails.dpdk.org (Postfix) with ESMTP id E3F584028B
 for <dev@dpdk.org>; Sat, 26 Sep 2026 18:51:47 +0200 (CEST)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-396ccdaea76so609385a91.0
 for <dev@dpdk.org>; Sat, 26 Sep 2026 09:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790441507;
 x=1791046307; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sDYDpdQ5tbwI85OFtB4JMhvqB7c9mlonVhf8CqFHuaw=;
 b=JNrwxJRH6m05oU2DmFezMn0mOin7nrbGsE1hXukd2qOCvXsnQlCLnWLFkyMW+tSx2t
 hpmP3KSCCINJmgmEa58u/vPD2MfaDy8gKYF178vvVWWDvW0i8Feqv8cTIVPMFhMifvNM
 zorDatYnz8aSEZTk+HVvGdKxWjYq8VwkiM6YB3E3zfFcjP3rZUwub7olR5niQO1p70FH
 7ErjtNzycM/dAOlmycU2D1IcOmYnulJTFL04K3+YrR0G3l0+rsZzUO4H06liFvg+XS7E
 rqEyiXYXtpDju95FP0CsCyLw3SyYJN69GDWdPU1HBV64BCGB3ML+iUPErsHV78ukwtQh
 ME4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790441507; x=1791046307;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sDYDpdQ5tbwI85OFtB4JMhvqB7c9mlonVhf8CqFHuaw=;
 b=Nx/JerLgynSJ0SPzak1vYea2lV8b6/zbhg2J9020m7cw7qFNaL7GbpILqQfvc+9161
 0jJhLHCO+dSw33IgoNZIdgVJsnGVmRx0kDdyqKbfsLARASVTXVPPP/OTFQGNJGNmnRaM
 Jb4HP3K9sm9RAPZA1MSo/kkQ4XNY8XxAb4znldFwdLTNSpfLXVni63UCvSUtIoAi99BE
 HgTGZnX8xcZ97cK0iZrZohjcVWeirouhUM4NG/Qv0vmk+2gYzssiIU9kVfmreQ57iR26
 cQe5EE3r4QZinFUezDMiccLXxYNVtfeCE6X2Tx9TbpebUuWv0OEGTESu7IIUY2jBeB1W
 lmjA==
X-Gm-Message-State: AFq9FYIUbrCtfT0CPp8JDmgBGuiyTV3/apDi950Dz8yKGBnV31zCIap6
 Iq6TUd/mELRxWPLav9TarGFvDjKIKYkC3NOnzPvfdJR759ImOImJpDi8aLPh+JtV0Yg=
X-Gm-Gg: AYBFou3lWYiyr/X3zrCvSACviIhhvL+GTYSbweTfdfNC+Lev/SwtBOHtB/pPKH9I2T/
 mYtFDJXyZKSncVdrNypFU9P6g68NxJXSdN3ZwhUqpYooHRYy+pXb4nYTS+E1LMCKUWV4+ZXnSsG
 EePlCpMyEUsDa/f3gbylDVBogkE3xggnVGvJHPKCMR5dlweVsiybX7iRVM/zeJSmQtcjiiBtC6N
 m0VGOs9vUrGdPaV36VxqmTaBurBUnrRekq9pDBvrVXAK5TqgYc7bFDUKZ4GXl3NaWWxcJ38vZKX
 n+eJmPtgUidDfT0eGrlTAVJP9acPN6USegG6lyJGsA+PeH74hHJSbtPV3nsfOObP4FwoAQhQIPT
 QhlXtSPNZilroyUP9qWcwx897cC7GvFAPJZdZAOnaVYlJNyiYFxbD4ix/RjVsD3z96H+N5doigz
 rs/P6jibrkJDNKnTF8jVneOE+biC55frMJD5UAn5bywSGdtsnGmDO0Iyp1pc1CMERLseOb+zwIp
 cZr7JC30wa3BSzXqt4PZwYNztoU5siwztb9u5x9z7vGeu6PO0A=
X-Received: by 2002:a17:90b:2250:b0:39e:6c68:fd93 with SMTP id
 98e67ed59e1d1-3a098b92bf7mr5146084a91.40.1790441506711; 
 Sat, 26 Sep 2026 09:51:46 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0b7d11124sm11765804a91.10.2026.09.26.09.51.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 09:51:46 -0700 (PDT)
Date: Sat, 26 Sep 2026 09:51:44 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Randy L Tice <rtice@cisco.com>
Cc: dev@dpdk.org, Morten =?UTF-8?B?QnLDuHJ1cA==?=
 <mb@smartsharesystems.com>, Bruce Richardson <bruce.richardson@intel.com>
Subject: Re: [PATCH v2 1/1] mbuf: add optional dynfield3 storage
Message-ID: <20260926095144.7b6d340a@phoenix.local>
In-Reply-To: <179036466858.2.6989648946195974931.v2-0001-mbuf-add-optional-dynfield3-storage.patch@cisco.com>
References: <179027866735.2.6802580807293251703.0000-cover-letter.patch@cisco.com>
 <179036466858.2.13982499480648014088.v2-0000-cover-letter.patch@cisco.com>
 <179036466858.2.6989648946195974931.v2-0001-mbuf-add-optional-dynfield3-storage.patch@cisco.com>
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

On Fri, 25 Sep 2026 15:31:08 -0400
Randy L Tice <rtice@cisco.com> wrote:

> From: Randy L Tice <rtice@cisco.com>
> Date: Thu, 03 Sep 2026 09:13:28 -0400
> 
> Add build-time support for optional cache-line-aligned dynamic-field
> storage at the end of struct rte_mbuf.
> 
> The mbuf_dynfield3_size Meson option sets RTE_MBUF_DYNFIELD3_SIZE
> in rte_build_config.h. A non-zero value enables the extra area. The
> storage is represented as uint64_t elements for 32-bit and 64-bit
> build consistency.
> 
> When enabled, dynfield3 is made available to the mbuf dynamic field
> allocator. The mbuf_dynfield3_copy option controls whether the area is
> copied by the generic mbuf dynamic-field copy helper, and defaults to
> false.
> 
> Validate that the configured size is non-negative, is a multiple of
> sizeof(uint64_t), and reserves a multiple of the cache line size.
> 
> Signed-off-by: Randy L Tice <rtice@cisco.com>
> ---

Ran this through AI review with full model

Subject: Re: [PATCH v2 1/1] mbuf: add optional dynfield3 storage

Applied to main (4f795dd), built and tested on x86_64 with
-Dmbuf_dynfield3_size=256 and 512.

Errors
------

1. Enabling the option breaks the build.

drivers/mempool/octeontx is built on all 64-bit Linux targets,
including x86_64, and has:

  RTE_BUILD_BUG_ON(sizeof(struct rte_mbuf) > OCTEONTX_FPAVF_BUF_OFFSET);

with OCTEONTX_FPAVF_BUF_OFFSET fixed at 128. Any non-zero
mbuf_dynfield3_size fails to compile with the default driver set.

The Known Issues entry is not a substitute. Drivers that depend on a
128 byte mbuf must be disabled at configure time when the option is
set, the same way require_iova_in_mbuf handles
enable_iova_as_pa=false. Please audit drivers that program
sizeof(struct rte_mbuf) or a fixed offset into hardware (octeontx
FPA buf_offset, cnxk first_skip) and state the result in the commit
message.

2. Fields can straddle dynfield1 and dynfield3; clone copies half.

On 64-bit targets dynfield1 ends at offset 128 and dynfield3 starts
at 128 (for both 64 and 128 byte cache lines), so init_shared_mem()
creates one contiguous free run. The best-fit allocator places a
field across the boundary, and with mbuf_dynfield3_copy=false (the
default) rte_mbuf_dynfield_copy() copies only the dynfield1 part.

Reproduced with size=512: register three 8 byte fields (96, 104,
112), then a 16 byte align 8 field. It lands at 120..135. Set it to
0xab and rte_pktmbuf_clone():

  abababababababab0000000000000000

The second half is whatever the clone mbuf held before, not zero.

Even without straddling, whether a field is copied now depends on
registration order and on what other libraries and PMDs registered
first. The field owner cannot know or control this, and every
existing user of rte_mbuf_dynfield_register() assumes copy on clone.

3. free_space[] score overflows for sizes >= 384.

struct mbuf_dyn_shm keeps the score in uint8_t free_space[].
process_score() computes align = 256 for a free run of 256 bytes or
more at a 256 byte aligned offset; the store truncates it to 0,
which means occupied, permanently.

With size=512 (dynfield3 at 128..639), bytes 256..511 are never
allocatable: a 256 byte field fails with ENOENT, and only 288 bytes
of 8 byte fields can be registered in total.

Widen free_space[] or cap the option. Meson integer options take
min/max, which also replaces the explicit < 0 check:

  option('mbuf_dynfield3_size', type: 'integer',
         min: 0, max: 256, value: 0, description: ...)

Warnings
--------

4. mbuf_autotest fails with size >= 256.

test_mbuf_dyn() expects dynfield_fail_big (size 256, align 1) to be
rejected. With size=256 it registers at offset 92, spanning 92..347
across both areas (see 2). The "too big" case should use
sizeof(struct rte_mbuf).

5. Copy policy is at the wrong level.

One build-time switch for the whole area cannot be right for every
field placed there. struct rte_mbuf_dynfield has a flags member,
reserved and required to be 0 today. Keep dynfield3 out of the
default allocator and hand it out only to callers that ask for it
with a new flag. That makes the no-copy semantics explicit and per
field, fixes 2, and removes mbuf_dynfield3_copy.

6. No test or CI coverage.

The option defaults to 0, so CI compiles none of the new code. Add a
devtools/test-meson-builds.sh build with the option set (it would
have caught 1), and a test_mbuf.c case that checks placement and
clone behaviour of a field in dynfield3.

7. Missing documentation and rationale.

doc/guides/prog_guide/mbuf_lib.rst describes dynamic fields and
needs to cover the new area, its copy semantics, and that the mbuf
layout now depends on a build option: applications and secondary
processes must be built with the same value.

The commit message does not say why the existing per-mbuf private
area (priv_size in rte_pktmbuf_pool_create()) is not sufficient.
The cover letter does not go into git; the rationale belongs in the
commit message, along with the cost: every mbuf grows by at least
one cache line.

Info
----

8. RTE_MBUF_DYNFIELD3_CNT and RTE_MBUF_DYNFIELD3_OFFSET are not
needed, and defining the offset as 0 when disabled is misleading
(offset 0 is buf_addr). Use the member directly, like dynfield1:

	memcpy(mdst->dynfield3, msrc->dynfield3,
	       sizeof(mdst->dynfield3));

and drop the <stddef.h> include.

9. The sizeof(uint64_t) check in config/meson.build is redundant; a
multiple of RTE_CACHE_LINE_SIZE is always a multiple of 8.
