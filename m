Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57648C61DB9
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Aug 2026 14:08:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 712C64013F;
	Tue, 25 Aug 2026 16:08:23 +0200 (CEST)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by mails.dpdk.org (Postfix) with ESMTP id A29AA400D7
 for <dev@dpdk.org>; Tue, 25 Aug 2026 16:08:22 +0200 (CEST)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-84e507b079dso3069422b3a.0
 for <dev@dpdk.org>; Tue, 25 Aug 2026 07:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787666901;
 x=1788271701; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Cg+stsDkZW0vE7LftUXKWmuui+p0WwIeu1bdf1FQV18=;
 b=kjy12BLsx6ssTFx08iOCtMtOmzZzukIeo/8iNtV3DPuyNNHmmDvjAtSnbCZfU0/Xkx
 JIhfbKdjeAW9U0+zLJjK9YRlU0PP4uABJD4/wRmYTt/3NX91yFJDMCKJlPo8zfOR6Tef
 h+xiK4b8MmEyVm1Px5aqOORJwcLPPBj1EOL/ZyNn0WUcCzB/8CI2Q99on7n+jVEGkySh
 2BzwkV8KFzAzx77JQwT+cjLyz6uSA91YWjYDlCvNX40kUH45qZCnMhXQi6WCDy6mUxUs
 ErpVgqQlet56q25Pp+jFJtmrvRpRKgtIMSMl/VKaIiCX14/DDbB0SHqn/l1ZbfCfmO4S
 dAzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787666901; x=1788271701;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Cg+stsDkZW0vE7LftUXKWmuui+p0WwIeu1bdf1FQV18=;
 b=PSW2xzeihSgkX3KOva7GlMRihUbE95LxhubYlYVVl2hheCvYFkYE5Exh51abQlbNps
 ysl4GzI2T/V+L0MRQ6fdGfPb0HOF8eWqmuGqwWTrYzsshRGvK3KMt9JXbMaSyCfcxgCq
 EHR98Fw9NMbSppOZuRRRMUdg2yIcLUB6TTa3BOpE7/zH8kQ4R+URpwR7bikk0Zh0D3yc
 lCmv6R1vtZgk3GKvmiqMRL7wYC1QqZG8uUVvrWsbCxEg4mFDOoIksXDxFTBpV46lo2pT
 o/sF17b2NrcpDfvHKFR3HbI47icHQVAsuOZThlR13uoHH8TzGNHNoeS96fvcLrLGpAEN
 pgZg==
X-Gm-Message-State: AFuF++lo5u83ke6Bi9dnahbnxHk1TvSkQf18gQeWaiPajZVslYP8Lfz9
 Iuoc2G9PtbiR0/uIUjM0mOGdaFLqTsJJJ3u8QK0jYjOV8OkIWXOIoSJezTDdMwm4+U4=
X-Gm-Gg: AR+sD10R02ciBJHICQOzRs+dWyetSSTga8lKfTlN40J4+yAh8S9m0cx/RLmsIzyrlUL
 p05ek/oP0KUi7TUxPDAjMzyDmasIBB6pv8/pPlRet3PfMH/5Mhisg2D2bGoFW7rAGPpsmZGZ5Q8
 tGeowMK6Lm05DCFyV2CoDs+9SCHN7/CFo/iaKtKIT6JlqvBG0nh2t769tf64TyKgLuGPktl6JFy
 N6p7OeX78bpZWN8qgSxzXvUTLCYEq9NTlj95WmjqwLauhVuZVBctSGfMRD+W1zdCCmIGWGrrbEj
 A1p27tYZl1jPac72egzf7ZqbTkObSE8PSpSPks+k0hVEqmyzbK7Xey/SQkCe3AZ4Y3w8jQC93GB
 j7dj9eD2gu8HOiw/Dl8tQdG+PmD1XI4YZsV6s6nr6iV+4XOJO9lYifXOLm4Eycznvh+TBfoFpqe
 eA8Z1wBDBKj1+NcJUXuDxnEe16UTU8vrppUsxSuvqKJH5UgjMmZNYilpxjrvpJ8PKZIXwddB+ML
 78IiiJYRR5AfmWlSkewUEELTuK16yRTIiSmQpXAcQ==
X-Received: by 2002:a05:6a20:cc9a:b0:3cd:f6c:6cdd with SMTP id
 adf61e73a8af0-3cd913262bemr15249567637.16.1787666901413; 
 Tue, 25 Aug 2026 07:08:21 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8520eed2293sm2912950b3a.2.2026.08.25.07.08.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 07:08:21 -0700 (PDT)
Date: Tue, 25 Aug 2026 07:08:11 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: Re: [PATCH v12 01/20] uapi: update to v6.17 and add iommufd.h
Message-ID: <20260825070811.2c834652@phoenix.local>
In-Reply-To: <01c816b3bd6ea703215164eedd92c459e8bc95fe.1787663787.git.anatoly.burakov@intel.com>
References: <cover.1787663786.git.anatoly.burakov@intel.com>
 <01c816b3bd6ea703215164eedd92c459e8bc95fe.1787663787.git.anatoly.burakov@intel.com>
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

On Tue, 25 Aug 2026 14:20:58 +0100
Anatoly Burakov <anatoly.burakov@intel.com> wrote:

> In order to support VF tokens for cdev-based VFIO mode, kernel v6.17 is
> required. Update internal headers to version v6.17 and include iommufd.h.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> Acked-by: Stephen Hemminger <stephen@networkplumber.org>
> ---

You should probably go to 7.2 kernel version if patch series gets updated.
Since kernel / userspace is stable this would help.
