Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA8BF8FA85
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Apr 2026 14:23:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C21404029D;
	Tue, 21 Apr 2026 16:23:22 +0200 (CEST)
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176]) by mails.dpdk.org (Postfix) with ESMTP id AE2594027C
 for <dev@dpdk.org>; Tue, 21 Apr 2026 16:23:20 +0200 (CEST)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-2d868d014a5so4097338eec.1
 for <dev@dpdk.org>; Tue, 21 Apr 2026 07:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776781399;
 x=1777386199; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YkT+0dTQClTPv5KLRcclSbtDf1QRHml07gyfBGaOHo8=;
 b=lCMZtRf4olcrvzfaXlTPWhYYMJ+paP7xA3xKoAFXQEp9NnWxbzQhPLntSMrQ9HTsf1
 31kpnI288Ihoc0cUh4d/XS4Rt1mSMHwD9aECe0exknTnlTaw92HXAkohIV4BvFab22qU
 MyFNJbAUsxs3bG3jWDLA2K0IZ5klF6dio5sA0n2btoGxiqnsNdSqh53jOD52qTI11KNK
 6xfrq4ozLt7hJ1XwQc9JSElchl+p9dxc5caxgTJTU1mF9OMSFH2ZUuXgEa16uKFphRHW
 dUFMiDXBCQw4lnIzuLFnQFLiJmEiWQV5QMczPhUMlhtMkH1KxbKkgyGoiErJVE+2Gn2y
 5RnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776781399; x=1777386199;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YkT+0dTQClTPv5KLRcclSbtDf1QRHml07gyfBGaOHo8=;
 b=Dg69cIow7CJty4AEnnwgq5Ow4DMWARe1Yo890VDevHbQJvhA2XCfO+B18i5F2FmgwY
 CYntUS5rvy+wI6vGjjr/zHN6o5vwNLXPAR/9KBghhR6bHaLjJK6d0meQ9Uvntx/2ohaJ
 spt7sEtohn2ocv8LNTlMlIxCALQB51GpaWCtf1FD1z1L4JASd/ZFIti4qJLEGTq9B+bd
 OqsbJF1nEojD3R7yjOCxRj+/x4fSg5w4iQDKjoBlsiXWFkLqQ6unJDhLgZ3aZwvSqaXK
 SUGQbvog9eLX8qvPXWE4xhRdBiylHOnvDZ7Wv5FEzFtPgk+Bg++DkBgFiKK5XWq9Q/17
 1Rrw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/UuYF/ACLJ03uEoPtQIduxvybbRnKLB7NJCGbOiu0hQ1tZZphZ1b8zoE4EVYTHu03oUkw=@dpdk.org
X-Gm-Message-State: AOJu0YxkRVWGb6MCJaG44tFeD6+wbaRKFyH4eaH7mKkxhq6S9zvKxfGs
 NO0ibBHWwn0Kx5XE1UhhInaFAp2dmilEZ4M2xLC5GEu/WzAXO3CJ61B3WafKKat+eXc=
X-Gm-Gg: AeBDietsEd8puitI4tkkxia/BuiHMCbM/vIkwYOX8eiH4ExErrBS2XgkxMB4LEZwxpE
 00PEHmWZ/el2iri6KbxmKKws5gUS5rPmdQQNTQC76SakI/lLH6mPUiOiSlx8CYbLC0QmffAIuFh
 RfLBWbzKAtiMtvXCwKSAe9XAaakTEdOSYWs+YDtzq9YAisrZHxd2YDRw/mdCQUQkE2SsOsMCjjc
 g8Cpjn/FrHXBq0a9XjFwa5xX+M4wQnkJNp298PRQmSWIDaG7KAGJ4Oid/19gC8wOd9WV6HaoXoh
 jTwvJPMgnZVtYl/2pFyN6nJQ5QsY4zFQRS8IG8wORieudubp/0W7UyU0L5VnGryCwO37mFgLxhP
 a6vqS256liyuH05Yshjd2wLPVRFI3qjhILR1goQN/wGyeN/SC4mtzomzBYxTXCMHfLWLFqTXwFM
 bkYu8c3BphHkGwKHFNzITwR2sis/1gYnkXZkFzLYZIl47rkSAPH6FQiDti
X-Received: by 2002:a05:7301:4094:b0:2d8:dffd:f765 with SMTP id
 5a478bee46e88-2e478a317b1mr8775537eec.19.1776781399132; 
 Tue, 21 Apr 2026 07:23:19 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2e53a4a64e5sm19137098eec.7.2026.04.21.07.23.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 07:23:18 -0700 (PDT)
Date: Tue, 21 Apr 2026 07:23:15 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: "lihuisong (C)" <lihuisong@huawei.com>
Cc: <anatoly.burakov@intel.com>, <sivaprasad.tummala@amd.com>,
 <dev@dpdk.org>, <thomas@monjalon.net>, <fengchengwen@huawei.com>,
 <yangxingui@huawei.com>, <zhanjie9@hisilicon.com>
Subject: Re: [PATCH v1 01/15] power/kvm_vm: enforce enabled lcore ID check
Message-ID: <20260421072315.2a57d5df@phoenix.local>
In-Reply-To: <46a0f67d-a8be-49a5-914c-e7a5f02ff3a8@huawei.com>
References: <20260416030612.2379407-1-lihuisong@huawei.com>
 <20260416030612.2379407-2-lihuisong@huawei.com>
 <20260416084825.0a371d4a@phoenix.local>
 <46a0f67d-a8be-49a5-914c-e7a5f02ff3a8@huawei.com>
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

On Fri, 17 Apr 2026 10:51:48 +0800
"lihuisong (C)" <lihuisong@huawei.com> wrote:

> On 4/16/2026 11:48 PM, Stephen Hemminger wrote:
> > On Thu, 16 Apr 2026 11:05:58 +0800
> > Huisong Li <lihuisong@huawei.com> wrote:
> >  
> >> The locre ID in cpufreq power must be enabled core in application.  
> > Spelling error, use checkpatch next time, it runs a spell checker.
> > Also run devtools/check-git-log there other issues in the commit messages.  
> Sorry for this.
> Yeah, I used checkpatch.sh and check-git-log.sh before sent out.
> But it didn't found this. I guess that because the "locre" is not a word.
> >> Use rte_lcore_is_enabled to verify lcore_id.
> >>
> >> Fixes: 6f987b594fa6 ("power: refactor core power management")
> >> Cc: stable@dpdk.org
> >>
> >> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> >> ---  
> > The rte_lcore_is_enabled() will return false for service lcores.
> > Is this a bug or a feature here?  
> My understanding is that the ROLE_RTE core is used to tasks on data 
> plane and the ROLE_SERVICE core is used to periodic or control-plane tasks.
> Currently, power management in DPDK is mainly processed based on 
> services on the data plane, like the usage in pmd_mgmt or l3fwd-power.
> However, the tasks on the service cores may also occupy 100% CPU.
> Therefore, power library or driver should be able to be work with these 
> tasks.
>  From this perspective, allowing the ROLE_SERVICE core to set power has 
> the least impact on applications in this series.
> what do you think, Stephen?


Service lcore's are just things doing other work.
They really should not be doing non-blocking poll, that is a mistake.
The service cores are intended for control path things.

The power API should ignore them in general but not break if a user
calls a power API from a service thread.
