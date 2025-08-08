Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39E6C87FCB
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 Aug 2025 16:17:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 16E0A402AB;
	Fri,  8 Aug 2025 18:17:43 +0200 (CEST)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42]) by mails.dpdk.org (Postfix) with ESMTP id 975AE4028B
 for <dev@dpdk.org>; Fri,  8 Aug 2025 18:17:41 +0200 (CEST)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-459e794b331so14822545e9.3
 for <dev@dpdk.org>; Fri, 08 Aug 2025 09:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754669861;
 x=1755274661; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4AggQjGn6RbPsBpCgHvZ1ORbX9g44hgITpPwTANAAdk=;
 b=iHqU3D1WG1krqUCGjbpLbcdeWbp1jfpdivVE6O1zILReUFkSYw8BX3+TWEjVPKwZPb
 AFieX3HlHr3vqblWnJQ7e0rL3sAhk7fvKtqb9CcHJTxH63oUmxeJ9hyp0fXnckUukSfk
 Qgz1c3qnuh5+plzgZAED9vdsOwjTsRHSJdXUVoeVFe+n+0TsGg1QQj+PVTVu91Vb1tCl
 pFiiRNMvAq6ywmiLvzeCKoefS7srgHXvJ9gutfZypHUr8dbUbpC4ad4FkH6hVXyQN2V+
 QMwHebwnWNkZM/EnRYq+76N0U0gZkPamfdINu34SH6u8CpkYh/MMOSHAV0dgzfG23fEE
 eA4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754669861; x=1755274661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4AggQjGn6RbPsBpCgHvZ1ORbX9g44hgITpPwTANAAdk=;
 b=BR+Os7HwbwtL86mo1fUnQlyv/yuzYSmQAFVQUQdeFkOW0IytDeXBcyvoJeAMLBwMxn
 wMXSREiZxOPeaS1zBTwbMNPqhsi+MOC9r/tOxcKXFta0fDHhHTJJu502kCMpSqnNxQhU
 Da6e96EjsrfTXbbQz2+GovZvZSPNdpanDASf4wQvRdwjpYfW65nu3QkQUZ1z/VP/n9ls
 OvXYwSk3HPscg6VzSi5dqwDHl2/i52DyODi8G6Mhpslne+e1XuAKtI/xy2sz5RHoI6FJ
 AmDtBqsQ5KkfUiIqdnfy5yx8Sg1ko9AYFCQBZtJ0xVYBpyj1jayWhjmBw3yMig/tlvFa
 vtGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5y6MI9hnBn+HALCnUedL22eiPw5vo85OX7gLS3O7CKgf0xkX9XHGzyg3ABspueYvz3LE=@dpdk.org
X-Gm-Message-State: AOJu0YxKAlg80Laxb2Tu700lb1LdvFErumON4sXtXhQQ/lSJ59ZIP4/J
 b+nXpA1FYF98nXKTPXwQ/QFP9m6wjIoCtMajK5vxur1r307kg+nPpnEAKjl+oB38jfc=
X-Gm-Gg: ASbGncscwad6AUMJzeZFVF18AmNqNtI8L7W9No5CXvtPC3KzY+h2bh1K3udSlE3Zp5x
 CVH6xRf+Ddwv2Vs9bZgILE9Ue6XSCLlJHccfvBf+ms6TaAH8Z79coBc9gDZM7PxKnADD6j+466r
 922DGVK6MAkCOZ/wLPLTdTk/YlGC//4i8YVjDmvd5JuSa9oHknftIpUZ5NalylE9b3rtmO0jSgW
 MB6rWV6DHFvGoz3y/KpC+ubYtd+xChDUAPEvtqIDrtxEWBil+8FEQiggmUJ9/3iJ8xIps8JQhAo
 Y9rZ5ySir+60pVQg/3ijCDzUgBBB00O1YJ6w67F55uHK9cx/WbjloKhTeAFlI8Luy8+geb/v4yn
 TlvPqB+n+yLQ+x+S3acRqk/Gpm7x8aVVoVJMN11fzj8WFfRrQwdKhn5FsOlToNBcPrWeVo6Sog9
 Y=
X-Google-Smtp-Source: AGHT+IFaDnz4/rWbvbKLmO+59BbCfOCeqMFa1atuzHOtizmwIiZFVwZ+d5BU3a4zHEc44F++JbStqg==
X-Received: by 2002:a05:6000:40ce:b0:3b7:c703:ce4 with SMTP id
 ffacd0b85a97d-3b900b6aad8mr2778504f8f.59.1754669861127; 
 Fri, 08 Aug 2025 09:17:41 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458af917d20sm175601055e9.2.2025.08.08.09.17.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 09:17:40 -0700 (PDT)
Date: Fri, 8 Aug 2025 09:17:35 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Varghese, Vipin" <Vipin.Varghese@amd.com>
Cc: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>, "thomas@monjalon.net"
 <thomas@monjalon.net>, "Yigit, Ferruh" <Ferruh.Yigit@amd.com>,
 "andrew.rybchenko@oktetlabs.ru" <andrew.rybchenko@oktetlabs.ru>,
 "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>
Subject: Re: [PATCH] [PATCH v5] app/testpmd: fix segfault in secondary
 process by monitoring primary
Message-ID: <20250808091735.561e6cbb@hermes.local>
In-Reply-To: <PH7PR12MB8596F632CAD6508EA7EAB843822FA@PH7PR12MB8596.namprd12.prod.outlook.com>
References: <20250729144850.2392840f@hermes.local>
 <20250730052412.78178-1-14pwcse1224@uetpeshawar.edu.pk>
 <PH7PR12MB8596F632CAD6508EA7EAB843822FA@PH7PR12MB8596.namprd12.prod.outlook.com>
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

On Fri, 8 Aug 2025 03:44:40 +0000
"Varghese, Vipin" <Vipin.Varghese@amd.com> wrote:

> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Hi Khadem,
> 
> Snipped
> 
> >
> >
> > Hi Stephen,
> >
> > Many thanks for the fix and for the suggestion that the secondary should exit
> > immediately without attempting any cleanups once it detects the primary has exited.  
> 
> Can you please explain why cleanup of secondary resources are not to be done, If there is specific memory like external hugepage backed mempool none of the callback will be called. Also releasing internal stack memory and heap of secondary is not cleaned.
> 
> Is there specific reason why you do not want to clean? If yes, can you please point to the right direction what is breaking?

What happens is that both primary and secondary process have a list head
that lists devices (like ethdev).  The ethdev's shared part lives in huge pages.
When primary exits, it calls the cleanup which frees the list (local part) and
the shared part.  When secondary calls cleanup, its local part now points to
freed data in shared huge pages. That leads to all sorts of issues.


There is no need for secondary to do any cleanup, all the local memory disappears when
process exits.

Also, there is no locking between primary and secondary process.
