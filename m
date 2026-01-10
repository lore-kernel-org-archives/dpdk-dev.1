Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A05D277C1
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Jan 2026 17:28:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 958AE40E1B;
	Sat, 10 Jan 2026 18:28:22 +0100 (CET)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51]) by mails.dpdk.org (Postfix) with ESMTP id 8B5904028E
 for <dev@dpdk.org>; Sat, 10 Jan 2026 18:28:21 +0100 (CET)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-477770019e4so40122125e9.3
 for <dev@dpdk.org>; Sat, 10 Jan 2026 09:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768066101;
 x=1768670901; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Th2AIhWXLLyrz+eN+KxF+VggtWE9ToKp4nAoWy28Qkw=;
 b=b1W99ErvUItYoUdWH78gCjCsiZnY1srAe18bucr5MwYN6eqYgaiKBygL+sGbr/Dg+N
 qcIX3/FtojjW00gi9PQxyRaN4MFEERcU+y7hvKIHL5WZH3drOIrWl2HKoeoQcww4iwsW
 O1Bdj6rBpCB3PLN0mLDQGnwT/eJGF2vOg5bi+Crb4pTPtRo2VhOy7hNqnbtRKBGOzsJ9
 w6hQ/vV5AZGWYQB80zXX4wiYxNvHlhYWbYs69Twrul7ZZbjm385wDl60JgZlhlgvqsAI
 mfvtGVnV8x4Rtwj738YmQ66sWPl6fcPt5ayZzuehAjwDD0qgPXIR/s6wUGljatEMUSz2
 dWEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768066101; x=1768670901;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Th2AIhWXLLyrz+eN+KxF+VggtWE9ToKp4nAoWy28Qkw=;
 b=QU9eH83SX/qluRaQbrE84i2Ifs9wq3jmmKt7E7qN1Q6WljKdcPTlccGg1Vczq6xxtl
 JVW5KJCs9sL8ZlxJrcnepaONeZAT5zjJ0EWOVNklfKpN0x0whBIh9NofvsTTH03+G3C5
 n5DsDh2LfK3JheVAyge5yvyfaU7lKumquYHZyol0/KNbTJdbDHT0KIeh3Yresv/FLUTm
 MAGz2883JclrDghXfNVvOwOXLUpVqlBmTSkiiT26Rp0NwfVU1ZLwZLzVClRYtu0o7Hz4
 ZxYU/aXlVrhakVZ58SMfjkUmTG1rFqwpt5JpQ9EcUx8A+5eGl5PD+EAUV9kZwxQ2MStI
 FaGQ==
X-Gm-Message-State: AOJu0Yz5KzhNyzVfJnIfwmhVg7gFPmNgM4Mxekdy/xkn+Jtc0bx5T100
 9gsy3jqpbkUR4C3PBqjS0j4eitXaj5lSmc1+V4dd7VLNzedqmt4uO07UmqSg9SCB36c=
X-Gm-Gg: AY/fxX5WgUgdGzJ5Wt0/Dr6GZEUj+Ei2wxTCdYM6yA0se1+iDtmLvCzc3jLHI2YQuYt
 rHlQeKv1dmsxnuxxhdLdCpMKb/SiIMWRp6eQJxXVUo71lliCBNiBywuvtH7QAL4LJ9J39E75ppL
 MC/DMa0Nbxx9qpes9yRT4JfmEx+VZKHuv88DOfQP95bmXD1v6TKqA7yx4P42eS2c1h2FzgPM1D6
 1/XnVzrpQr4aIO+Ahw81PJGGGxnwn4gPvwMCQC3zkzQl83DzGyxCNIiL46Rhe6/m1D9wYG0u0LK
 fi0/0LmfOQ3ihuJnhLxUJXud4rpdlf+49gHU6Gn5yhs1O/YaNvvMeAkScic3oXy7jNbY2PZppid
 pNPhUuDFdvGMi3LqX1uAMaxXfWYbw2gBFDMvMIjIe66zX+GRXDZkRll8LlzYj8hELys0qQDQ8vs
 kbUHdc+DRc3/9GeB3E9NA+w/N2dCnpt3LSeVy9zKqAaVeGvGl01mvl
X-Google-Smtp-Source: AGHT+IGW2vf3maTDlLKIYV61BN7VlkQs/N7iDshIoEseFDUSSUpiVEDieqYX1O63w/41Ibs2bYLH2Q==
X-Received: by 2002:a05:600c:64cc:b0:465:a51d:d4 with SMTP id
 5b1f17b1804b1-47d84b09250mr146189985e9.6.1768066101100; 
 Sat, 10 Jan 2026 09:28:21 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f653c61sm269757475e9.10.2026.01.10.09.28.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Jan 2026 09:28:20 -0800 (PST)
Date: Sat, 10 Jan 2026 09:28:16 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Marat Khalili <marat.khalili@huawei.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [RFC] doc: add AGENTS.md for AI-powered code review tools
Message-ID: <20260110092816.75c398aa@phoenix.local>
In-Reply-To: <bc4a13bebde740adb57e80c5156f3cde@huawei.com>
References: <20260109014106.398156-1-stephen@networkplumber.org>
 <bc4a13bebde740adb57e80c5156f3cde@huawei.com>
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

On Fri, 9 Jan 2026 09:58:38 +0000
Marat Khalili <marat.khalili@huawei.com> wrote:

> In my very limited experience it helps to tell the model that all commits (both 
> patch and commit message) MUST pass devtools/checkpatches.sh, ideally 
> configured (and verified) as a git hook, clear justification must be 
> provided in rare exception cases.

Models don't really run scripts. Would like the auto code review tools
to do a better job of pre-parsing for checkpatch rules and explaining better.



> From the general programming principles I'm unsure about duplicating 
> information already available in doc/guides/contributing in the same tree. 
> Perhaps we could just instruct the model to read patches.rst and 
> coding_style.rst, they are not very big (and models typically know Linux and 
> PIP8 rules already). Otherwise we risk one of the documents becoming outdated, 
> or rules/nuances omitted in the summarized version ignored. In instructions 
> specifically for the model we could focus on things that are persistent source 
> of problems for it despite instructions for humans being clear.
> 
> Just my 2c, great that someone is working on this.

I am not sure that models will always interpret our documentation the same
and this looks clearer. Also, there is lots of overlap with other projects
which is not covered in DPDK alone.
