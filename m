Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8787A106ACEE
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Mar 2026 22:46:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4853B4042F;
	Thu, 12 Mar 2026 23:46:33 +0100 (CET)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com
 [209.85.210.45]) by mails.dpdk.org (Postfix) with ESMTP id 9E3EB402BD
 for <dev@dpdk.org>; Thu, 12 Mar 2026 23:46:31 +0100 (CET)
Received: by mail-ot1-f45.google.com with SMTP id
 46e09a7af769-7d773a4af0aso813729a34.0
 for <dev@dpdk.org>; Thu, 12 Mar 2026 15:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773355591;
 x=1773960391; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3MwMyuEmUv+ChsgWN9j2WpH1Bcrk0bQNzV3xSXoUzoo=;
 b=ExBirV3bWP2KAAO9/AuLcFr90dsbgp3OkHrmW+i3e5qnUWjIBX78Pk1v9Ut9jgTbsm
 LfTZHlZ/PPrEHmEQxo5SPz3Qbps++Mv2XaAxJ1LberNUvacPB23Mm9Ie3xvLCbrnKAqr
 c/ZHnnGjatjQKbbIqIF2VFpuZRr9ipE02XPzWy7JY+ZXTnKw4psEGjCxfcmseow+997b
 2/YcI4vMWpFcySx/TMcP9ibNEMxFyAE3W+zWX3hlg0xygX2eusw3Yhaz5ah/6DDOXwxm
 LbdVMpytY3VbpylTasWhU0qAkj4DZKQahs15NsAByLTjI85egZc/qHx/ZWGAol9hFYMX
 CkRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773355591; x=1773960391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3MwMyuEmUv+ChsgWN9j2WpH1Bcrk0bQNzV3xSXoUzoo=;
 b=n6yygWdAsyyxcQRKcynZrFJ4f9Ze7N2PJttICbURWYrB0dmpTVCBiAk3BnNzlvHPaK
 Fz4CXulAKEY8wzJuT2yOStYO34+CfQmgk81f5/sWtI19a7RG6PXROiMGrmmOtJysaW7u
 SPjYp6BsFR+PSkbWtbZwbq+qnjcYnoDwrS3DRwmFL4wOHHcHY9x9x95gZpElwCfKDdCz
 Fn05FJGj3hBiDrLHNz6fYy4KBB1SFRRuZkTKpWfJHsa8UjhDsEyYxRvaTqgaqYuHLpLB
 aF0y9LskaQQ+fs0bCgJizlfRfsnEjynh02zWSej59fJf1Px8CaNiBuXidcDzRKE22395
 ZJ3Q==
X-Gm-Message-State: AOJu0YzFaZfzxstutiRW5errD3Nxo5Di/FMVopFCMQXvHPCk0PfEENth
 NwYvVPVsEucwRqVKbVqUu2VA9c5Ks/SFi255ngoNAeYpyJCleOG8RsWnn3fYC1QKDv5718dBm4Q
 3i58V
X-Gm-Gg: ATEYQzyrwa0dknTDAZJSfm9JXZKkvyBNQ6WXXwuuE1a5MPvoKlJGeE7+tdLqhm99h/d
 NyuRrAfX10mkTsWYAKuhNtgK5p3kuH9kpwZVa3PI5ZG7TggZs4GLe3j6JFqKVUDg9TwSjJR2V3R
 qvN0dsNhwFemKEQcRe6/sInQxYFTQVN4333u0BasrZAFfRZ8jgge8yMDsOr5Ck/3CqX9u036zc8
 jCn+tOdNLAoV66HguKxGYD25Wc8JIPTiuPHKRlP1oqELdi1iFe10GCovaeDwODF0xguORQ6hqsk
 ZAf5VvAgnsgnlK9nG6SUl+9Np4VHHwNtH1qhXSKgmxARU5JEL9I4pKctM/S2XAZSYK8NnMe8Pje
 izsMfnXETSgfJq6RYr35TJMx9ZwwcxV9zqkQt+C1lHri7qJZAlsWE9gFjNlLvzrdzraSGslsakx
 kEK8tBbMmJo7axUps5bbw50yRJEOnIsH5JHTM=
X-Received: by 2002:a05:6830:3c86:b0:7d7:5e74:f4d4 with SMTP id
 46e09a7af769-7d78249e96emr763629a34.14.1773355590622; 
 Thu, 12 Mar 2026 15:46:30 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76ae68a4bsm5002422a34.19.2026.03.12.15.46.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 15:46:30 -0700 (PDT)
Date: Thu, 12 Mar 2026 15:46:26 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org
Subject: Re: [PATCH] devtools: add Co-developed-by to commit log check
Message-ID: <20260312154626.6b34e8af@phoenix.local>
In-Reply-To: <3328846.5fSG56mABF@thomas>
References: <20260312185403.1051832-1-stephen@networkplumber.org>
 <23032153.EfDdHjke4D@thomas>
 <20260312131039.6ec4ddf3@phoenix.local> <3328846.5fSG56mABF@thomas>
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

On Thu, 12 Mar 2026 21:27:01 +0100
Thomas Monjalon <thomas@monjalon.net> wrote:

> 12/03/2026 21:10, Stephen Hemminger:
> > On Thu, 12 Mar 2026 19:56:25 +0100
> > Thomas Monjalon <thomas@monjalon.net> wrote:
> >   
> > > 12/03/2026 19:54, Stephen Hemminger:  
> > > > Add Co-developed-by to the recognized tag pattern and tag
> > > > sequence order in check-git-log.sh.    
> > > 
> > > Why using such tag? Signed-off-by is not enough?  
> > 
> > 
> > The tags were inherited from the kernel development process.
> > 
> > Signed-off-by is the DCO (Developer Certificate of Origin) attestation. 
> > It says "I certify that I have the right to submit this code under the project's license.
> > 
> > Co-developed-by explicitly marks someone as a co-author of the patch. 
> > Without it, there's only one author recorded in the git metadata.
> > 
> > I just wanted check-git-log.sh to be quiet if it was used.
> > 
> > The Co-developed-by is new, and probably came about because some people
> > need/want to have their contributions recorded in the git statistics.
> > Silly corporate overlords count contributions and it matters to them...
> > 
> > PS: If DPDK was exactly following the kernel process, every time a patch was merged into a sub-tree
> > it would get a Signed-off-by from a maintainer. Because the maintainer is validating that
> > the submitter had the correct rights.  
> 
> True, but in DPDK we use SoB as an author or co-author mark
> and it is well in line with the DCO.
> 
> I know that we had some exceptions asking for Co-developed-by
> because of a corporate ask, and I am on the side of being flexible.
> But making it a part of our official process could make things confused
> I think.

Agree. Want to allow developers to use Co-developed-by but not
suggest it or document it as required. Some people seem to want to use it.
