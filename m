Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED2F5C79F82
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 16:54:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 403F740E13;
	Tue,  8 Sep 2026 18:54:57 +0200 (CEST)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by mails.dpdk.org (Postfix) with ESMTP id 30FE64028D
 for <dev@dpdk.org>; Tue,  8 Sep 2026 18:54:56 +0200 (CEST)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-8525efa7274so3382159b3a.2
 for <dev@dpdk.org>; Tue, 08 Sep 2026 09:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788886495;
 x=1789491295; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rroTDyoix/QzxPPfc6LUfZNtjLA1ALIdiYMWBYucTec=;
 b=lR6WXcoIB3D+WNbAwIZpAYJUay5Fy8nHRtaWUZ1as2Mf+4bdXLgHtGiiDqYZT3f4qy
 nqcjyVpHM7d5AdjFi4+qqVilNrfD9DwpyXdSWWDy3LY8fp38TLBhTaPPBs7EUbVdwUs/
 ES2MES4+9j4d1FTKMRST9hzpU2EvMaBbQczoo5T9VjZoUH/a/pbrzFgFh1JHJbEXxCdW
 YkGDRbb++BWusxVrwBsg58IDcuv7t5AdcHUl/gg+KhfKkGNDvPbXpOFWJWfEANXOhZu6
 d+qJtlfaZMOpG9jYjRUhQxIYEqrJL3QJhFRX5CI8KJluDpKf5DvxAjJNHdgHcb3pQt1S
 mApw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788886495; x=1789491295;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rroTDyoix/QzxPPfc6LUfZNtjLA1ALIdiYMWBYucTec=;
 b=IK4+B3DaVEKK9ZeOZPPWNxN9wlSOJSGmU5jl99dE5cI39xa40EykQskHLgRBxDjrFt
 zx+JU4eJyTIzzFyGG9+M729hLTRetsz9GEqFO4VrFKyEefscDo+BhaNWcAK0rtpokoGN
 geBqDBycLs6O8JYjnn525IVHjlUE2l/0brjnNL/fZ9U7uXWVJGQndGT2k2teSHJsyjPb
 +Q2OxoEq19I3O6N0vRUrWPzqTI4qVrOAYi8XWaQKP0kHpHVUdPM3+aDntSgocfx2CphW
 QD4E9PK8IFt5OdxWrXMLbiGA48wp8POulTlSo5EZwykhLdm0nWVhWG9pSmYO2R9jJaaR
 KHyg==
X-Gm-Message-State: AFuF++kFD3bsSHF1uAGQXVmvV4KRuIW9yxmSzvgLYtX9+uzzJ2+Xzl6N
 OTPfymQ+6g3B81cdCP/V7pIk3er+/UJmaIg4xLB0+OGnRMOxKFevEL71tcyLdCH3QcqqAiRJ9f/
 pwhny
X-Gm-Gg: AYBFou35v77YRp+MEhSW0oWK1wumzjpDaRx73Jt7LOcp8BxesJD6ZwWTL6YmhF4F4U4
 0it4Lb8nPe1+aFbuLRpQb0NH811oLLgK0dRp3GnspbbgGqki9QwWxH3ilwUYaiddTR0zWIgx+7y
 whmU/BbxcDDCm43q782jSMmxhN6/SKFiRIfDFcRTrUWvnA9KxiIhzxLjW+v95kLgNGq5VY7svWa
 8kIfHp//+TEljkpqzGMO/ezz35XvQ9yF8z64vCwzgzE8/aGYPqxBr2nt0xDgKvKgiz+1r+s/e8c
 ZZuh2QD3M/yYpl9dvDU4dvFlTKg9zeQm7ji6/fVfvB//ZbQQc1iPNrg2fyvdEDP12XaS+UG4VzZ
 3/lzzg6Sqjk9Ye1fmH5zdXxXKcvjtsTsYuw3Ux8lGXiCRB82w7UkuQCx/RTlqXUizZECxexpUL/
 WXEyu3ceM5VOQpgMZcR/0KGdC9FmEPnm/KywP2MnX67OwbkAlbqJHjzAA/j1U4GulL7E2G2/1yQ
 Iq4Xyt8bOKOnOqYy0TbcvIIcFI=
X-Received: by 2002:a05:6a00:218e:b0:84c:1cd2:142b with SMTP id
 d2e1a72fcca58-866b2eacd05mr11166524b3a.9.1788886495119; 
 Tue, 08 Sep 2026 09:54:55 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-86207a4d602sm5096741b3a.22.2026.09.08.09.54.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 09:54:54 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 0/3] power: fixes for amd-pstate frequency scaling
Date: Tue,  8 Sep 2026 09:52:31 -0700
Message-ID: <20260908165447.450006-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260328193419.106100-1-stephen@networkplumber.org>
References: <20260328193419.106100-1-stephen@networkplumber.org>
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

The power library does not work with the amd-pstate driver in passive
mode. Initialization fails because the current frequency read from
scaling_setspeed never matches one of the synthesized frequency buckets
exactly, since amd-pstate scales continuously.

The first patch fixes the matching. The second fixes an unrelated bug
found while testing: the sysfs file is buffered, so a frequency the
kernel rejected was reported as success. The third fixes the unit test,
which assumed the nominal frequency sits at a fixed index in the table.

Tested on a Ryzen 9 7945HX booted with amd_pstate=passive and the
cpufreq_userspace governor loaded. power_cpufreq_autotest now passes,
with and without turbo.

v2 - fixed review comment from GPT
   - fixed two other bugs found during review/testing.

Stephen Hemminger (3):
  power/amd_pstate: fix frequency matching for continuous scaling
  power: check for errors when writing frequency
  test/power: fix nominal frequency check with amd-pstate

 app/test/test_power_cpufreq.c                 |  5 +-
 drivers/power/acpi/acpi_cpufreq.c             | 12 ++-
 drivers/power/amd_pstate/amd_pstate_cpufreq.c | 89 +++++++++++++------
 drivers/power/cppc/cppc_cpufreq.c             | 12 ++-
 4 files changed, 74 insertions(+), 44 deletions(-)

-- 
2.53.0

