Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A86EEF8D75E
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Apr 2026 15:48:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8E99740272;
	Thu, 16 Apr 2026 17:48:32 +0200 (CEST)
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com
 [209.85.210.54]) by mails.dpdk.org (Postfix) with ESMTP id 9444340144
 for <dev@dpdk.org>; Thu, 16 Apr 2026 17:48:30 +0200 (CEST)
Received: by mail-ot1-f54.google.com with SMTP id
 46e09a7af769-7dbe437b072so4418544a34.2
 for <dev@dpdk.org>; Thu, 16 Apr 2026 08:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776354510;
 x=1776959310; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qImqCvMB0eizpwaHpw1+lUThCVtzjWk3+AbbgZOJvXg=;
 b=dnqTBoDLiIPyPEACih43kaxt/Q6F44u2pM13j9oYhyZ0G7x0KGKO10Oyu4CHpkKITB
 /yshlaaiu6veUioxwzuusTkYCzdeKKiCtKnxm8Tk1E7E0AXdYqIsN3+rlYrqgyrQhzdC
 H36lrBRZOB6BjyTZ5nZO8KbnfsNNCANieiM7Jo6L/BuO16lI+c2Nime3AlzUQE+1N2Uw
 dvikEYbzcs8o1fnDH5OjJ1I2hvI0AZHN8ZmKwGH+5vhYBstvAkKbAa+twQ4/r64A1unJ
 OLS9wuyoB94mht7dyhIJ6T0bOlee00WIzBXWHUqYkMiEXvbGElFYi+eVdXs9FlJHO6Bl
 MrOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776354510; x=1776959310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qImqCvMB0eizpwaHpw1+lUThCVtzjWk3+AbbgZOJvXg=;
 b=cklt14QwgCoR/vLq3qiEo7iHlbH6nzrjUCoo5/TYBSMXe2vnurSTGul/DpmC9K6qGN
 wgNfbRWGokBWRz4klXVVpWYgJqdzwB9m6rIQCoSSkzU6F5A23g96Kab4vm5++OmoPUPk
 PupwywvvnsP9X/fPgWlX2eoRi0BFOSklhtCo4VWx1rCZwSojyTZXu7cVsNqEOlmcOijD
 kVgo1yNMXmOIfw7sjRBvqnxhn/9D1hhaHq24KYAJWZx+uNJfkdt80R/98qQEb8esd6qF
 Xg8rPOWTFXr8Y2mJdB9m56/yRn7xp1FoRpasS4h+Ub22xAS8dIB0fhffajky8XqFJDM1
 npPg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9MyuNIt3Jqy8PP1h9zIMI1aoBO8t/2JcvcWytN60kJ1Wd2b1DQRqkhI2J1RNcAG3i1I1U=@dpdk.org
X-Gm-Message-State: AOJu0YzNp4NBWukrGAUR3OoJNODdOvn11W/QeRuzeowWKBKufFOAUOQE
 ewe5LbpkkoCAV7ij99U0ORUppjo++hLxUY0SDKbRObsCOPHH2Nva6onBkCQdXQeJdqg=
X-Gm-Gg: AeBDieuGy4io/moiupzFi5e4drijFx8X2vwbVSqpMrgxD7fCMK/Usku4TbjrIDj0YjF
 0hEVB/CexiqEKb6awej56KTymYmMxuEszeLbdugCKOLQn9sGAKN5y0pOnuJoYsHcQiEOrj+GNzt
 1B2THPH79hGWhqybaQgwy4eZ9kdT1zp2UUenN+zK2pNs3mrIyxBbtm0DrGBpLFCZUeEeECKSf9r
 SPXhTBjyUuh5TQpLUqXJ2HwBJOlZV0pjgKzZbXd0kf6VzPSEL11829PeM+BWpOZz7gQaMmcO7aa
 tFkymVYiu2+kZlxs51V8w8FwGCSKXnHmK39OUJ7EMhtHXkPsCDjWWdE33TvqKgBLuk+s7JiR0Ox
 Wj4O40ecyqbwrO/SRXJ4rfmN93FwKxuZ6XchgIqeslxUV2me+ydzjVad5Ti/fA8dCcXUd0OudIs
 cOAkuNnxaoref3vPQAZ4xOikpibWAZwOw7d052t9B4ZlnDt+oCQCIE+AH+
X-Received: by 2002:a05:6830:6110:b0:7db:b384:ec4b with SMTP id
 46e09a7af769-7dc27e77eeamr13020384a34.27.1776354509643; 
 Thu, 16 Apr 2026 08:48:29 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dc90a364dfsm182741a34.5.2026.04.16.08.48.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 08:48:29 -0700 (PDT)
Date: Thu, 16 Apr 2026 08:48:25 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Huisong Li <lihuisong@huawei.com>
Cc: <anatoly.burakov@intel.com>, <sivaprasad.tummala@amd.com>,
 <dev@dpdk.org>, <thomas@monjalon.net>, <fengchengwen@huawei.com>,
 <yangxingui@huawei.com>, <zhanjie9@hisilicon.com>
Subject: Re: [PATCH v1 01/15] power/kvm_vm: enforce enabled lcore ID check
Message-ID: <20260416084825.0a371d4a@phoenix.local>
In-Reply-To: <20260416030612.2379407-2-lihuisong@huawei.com>
References: <20260416030612.2379407-1-lihuisong@huawei.com>
 <20260416030612.2379407-2-lihuisong@huawei.com>
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

On Thu, 16 Apr 2026 11:05:58 +0800
Huisong Li <lihuisong@huawei.com> wrote:

> The locre ID in cpufreq power must be enabled core in application.
Spelling error, use checkpatch next time, it runs a spell checker.
Also run devtools/check-git-log there other issues in the commit messages.

> Use rte_lcore_is_enabled to verify lcore_id.
> 
> Fixes: 6f987b594fa6 ("power: refactor core power management")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> ---

The rte_lcore_is_enabled() will return false for service lcores.
Is this a bug or a feature here?
