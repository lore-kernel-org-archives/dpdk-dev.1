Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E39B6C43458
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Jul 2026 16:36:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0794040264;
	Tue,  7 Jul 2026 18:36:52 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 9E9824025F
 for <dev@dpdk.org>; Tue,  7 Jul 2026 18:36:50 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B6211AC1;
 Tue,  7 Jul 2026 09:36:45 -0700 (PDT)
Received: from [192.168.100.239] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D12D13F7B4;
 Tue,  7 Jul 2026 09:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1783442209; bh=740bApkOi96jHsbIBzzngJniUNXEJCPKo+AZxCgF8Ww=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=BPsS1Vf66HThapDNMr/gjWIuNqxrDBlQtpp1IfVQVJMGgJmBLhQ+wt2XfEJR6UioB
 43vEfFli9EeEKp9kgvNKXweoG4Yfik2UB3ebtQpzZK6xRYf3rJY6thkjQPYzkq6hM1
 h7h3ZTbT7MG0p+jfNp3QkftYyNRyMve9V3hJlo7w=
Message-ID: <0b37dd2e-59ba-4f4a-84f9-3ae6e37f062e@arm.com>
Date: Tue, 7 Jul 2026 17:36:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] dts: update test suite names to be clear and consistent
Content-Language: en-GB
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: patrickrobb1997@gmail.com, dev@dpdk.org, lylavoie@iol.unh.edu,
 knimoji@iol.unh.edu, ahassick@iol.unh.edu
References: <20260508141319.52648-1-abailey@iol.unh.edu>
 <20260511160013.78676-1-abailey@iol.unh.edu>
 <e135faa6-020a-42f1-a09f-e21e90dde010@arm.com>
 <CABJ3N2UPaeLyD7Mv1vtoQSvRJLK0MUfC0LHvvuz-kvjx1YKwcQ@mail.gmail.com>
 <CABJ3N2VPwsAoDyY4x=k=JQoU74UkdbQQRAy2LQgw_W9r-q8awQ@mail.gmail.com>
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <CABJ3N2VPwsAoDyY4x=k=JQoU74UkdbQQRAy2LQgw_W9r-q8awQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 07/07/2026 15:09, Andrew Bailey wrote:
> Hi Luca,
> 
>      I thought that I did this previously but tried again just to make 
> sure, referring to "git mv". The commit is clean when I change the name 
> of the files but when I squash my commit that actually changes the 
> contents of the files it makes the overview incredibly messy as before. 
> I tried doing the moves and changes in different commits and 
> squashing them, as well as just doing them in all one commit with the 
> same result. I did not submit two separate patches because then the 
> first commit alone would break doc builds. Is there something else you 
> would like me to try in order to make this cleaner?

Mmmmh, that's rather odd. You can try to reset two commits. So if your 
worktree has the 2 commits (before squashing) do:

   git reset --soft HEAD~2

This should keep all the changes of the two commits uncommitted. And 
then you can fix the renaming here and then do a final commit.

Otherwise... if nothing else works, will accept v4.

Luca
