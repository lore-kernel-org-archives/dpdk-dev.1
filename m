Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A99C98318
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Sep 2026 15:44:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C61664027B;
	Thu, 24 Sep 2026 17:44:15 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id B0A4940144
 for <dev@dpdk.org>; Thu, 24 Sep 2026 17:44:14 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-39d654f02baso6435a91.3
 for <dev@dpdk.org>; Thu, 24 Sep 2026 08:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790264654;
 x=1790869454; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jhqruIiyXiqqUP1aD9287iWNo8noBfTdCrRsSlBnVc4=;
 b=zAn3rzMJXw7gfDyB13olX4UK+axF642McyecY1hDwN/050Dt6sZ5znsPaZosHXu6r6
 qczuROcFV+Nl9yRRJDLzuQSwdWQ7vA1XLWMcl0qAMPk/nerN+B6Q4FPEJGKG9NIwMGlE
 pl6ftCBBTPbWJI76vqDQbxGxBeFcl1fu2vn6htsaW8gaYd0DYYHiNJ8fx97n75wvJbzk
 OZfx76z+Mn7+Wbexm/6PkHV8SEZWQ972sTsomts8mZ8s+5+V9Qb6EE9gZ5IiG7CfmxAr
 O9MwU7MAgHft/I05KgmMt2yLeK28lQmdQTwixHstVSN45e68XxH6i3b875OOzE46tIXr
 3FLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790264654; x=1790869454;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jhqruIiyXiqqUP1aD9287iWNo8noBfTdCrRsSlBnVc4=;
 b=tuQ0qCwOVrWJ4wgUgjrwc02rD5YPWDmPPZPumq/pwtuXRsOOvvDibKwcsLFhlRnVVA
 dqUanxghwotj9uqUUoUWk2RDIClaNUGJ6u+M2f0ISN4i3M+6Yo8D99RJbUYzsjuzW7Of
 ZO6vp2psPeuT/pLyJlrYRNxwZQiH4ImWWhruK5Thj3yU5rJUoo18463TlLCtcjLVghcf
 muwuTPxkiDnFox7JjIrCKVsSs71ORi7BYBJm/yfHrTWmLktc153BHRgWJIm0Fiu3ngLd
 c+sJnVAAkcO6PXN3OSeIUb9oNZechStXOf/9YzIo58zogSTPoLonFue83u0826uK5tAE
 NL+w==
X-Gm-Message-State: AFuF++mmrHm7JazhL6HliaMeZVqy8pvWoSHneR2VLFS6htRznF5jrAGg
 FyQA5uKkFkDqELuc/3UdD6gm8JtF1qplj4kdL5SsiSv1T4bRUQhqwKfWV1NpCy/nO56h9WNO0Cb
 mKYh46ZU=
X-Gm-Gg: AYBFou3hl+WuZlaTy2WCkBMhYMWjLxKn47CT3CwAQ80nhQjblwW0Z+fKsTBKeyGpFYP
 ppztbUOUNH1IKXIYaKbAmgISTt35+QHApErVJ6m+DCqVC6P5H9dK1RiKw9YDqXUUz/9pluuRLdN
 Ksshon+SB1chvoe8+NRtsMuws5h2yeGbICtNZb7eLsKMLwR/JFuZWyMi5/HJkhIIQHJ63KP0Q40
 EwwF8BzMm8f2wHW0bhBmJiEfwC55fYZZko11q8z4CYD8oslx7u6OY++a/AZSkXr0OtY8VVPtCQw
 Xa0r0xyjugsyRohNwyQ4rGyOrYOXM1R62riijrWg132kvCb07NvqUuusyIoAHWOa1NlNd+MDZ2b
 yXMQl3VKvG7aQ22bZrf7qeClSqq7arzvjBKpb5m7AyMuOTW4bikuE4E1e0OSO2B0R8vTIwQGDYu
 4xt6e3JjRBi3Ut1hjiAZt9nu2z+YIjffREab9es7ZRQKu37BQ0kGbFYI/KuReA5uqprT8tIZcqZ
 IgPERPZx2nLzBuOn9rFuMLTvdj5LEw6NDHnDkyl
X-Received: by 2002:a17:90b:1c09:b0:3a0:ace4:d2a8 with SMTP id
 98e67ed59e1d1-3a0ace4d6e7mr640908a91.17.1790264653554; 
 Thu, 24 Sep 2026 08:44:13 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a09773e7c3sm5381674a91.17.2026.09.24.08.44.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 08:44:13 -0700 (PDT)
Date: Thu, 24 Sep 2026 08:44:08 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, Jakub Grajciar
 <jgrajcia@cisco.com>
Subject: Re: [PATCH 7/7] doc: clarify memif secret is not access control
Message-ID: <20260924084408.6ba7e868@phoenix.local>
In-Reply-To: <20260922194138.508919-8-stephen@networkplumber.org>
References: <20260922194138.508919-1-stephen@networkplumber.org>
 <20260922194138.508919-8-stephen@networkplumber.org>
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

On Tue, 22 Sep 2026 12:40:58 -0700
Stephen Hemminger <stephen@networkplumber.org> wrote:

> The secret option was described as a security option, which invites
> using it as one. It is sent in cleartext in the connection request,
> and when passed as a device argument it is visible to other local
> users in the process arguments.
> 
> Describe it as what it is, a check against connecting mismatched
> interfaces, and document what actually restricts access to an
> interface. By default the control socket is in the abstract
> namespace and has no filesystem entry to own or permission. Only
> with socket-abstract=no do file permissions and the owner-uid and
> owner-gid options apply.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> Tested-by: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
> ---

Recheck-request: aws-unit-testing
