Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CAA6CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 01:25:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BF3DE40DD1;
	Thu,  6 Nov 2025 02:25:00 +0100 (CET)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by mails.dpdk.org (Postfix) with ESMTP id 383694013F
 for <dev@dpdk.org>; Thu,  6 Nov 2025 02:25:00 +0100 (CET)
Received: by mail-pf1-f174.google.com with SMTP id
 d2e1a72fcca58-7ad1cd0db3bso406826b3a.1
 for <dev@dpdk.org>; Wed, 05 Nov 2025 17:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762392299;
 x=1762997099; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YehNMVWP9SK4BdY7d8Pw85ImscMUoxMikMgy+fQJsJY=;
 b=Ax+bT5HdBtXIh/jQMb2mNbKl2jlVRytp8cT5rT8TzAEYGhX0lI+8FLfSmnGCD1MOgO
 jrzFy1yxVwJzMzmkYQaZxmx6iGB7hzlSH5dAIYqzDxX+JaJwFKQioxmubGbzLtk2qCed
 NrJpScq9rhL7h77qRKSo1BoA4T/mjs2iadaiuPo3N+zObW0w1XANxlNGSLwkB0k7fthL
 0fb3B1qTsaQISxRPNbv93L3O7Yys91q2yBpHcxHCY0C3KCh9+oocbO6Z3B1urLHCmnwq
 2LzmfaaMGQJ0bTwB2N8Xpedjqj+hCvXFHTA9LqWLbhe0DbFQ5IoifIYywUJTPtEzFzDZ
 7IeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762392299; x=1762997099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YehNMVWP9SK4BdY7d8Pw85ImscMUoxMikMgy+fQJsJY=;
 b=sQwvNgI8lOK5bK1F4FKTsoQSzHuWC+nlz8SjGK+AHZnmOJz3fQMNMNxJu9/vlRV/w1
 vtQDBBmgINuleqv9GnFhyMXuKmZCPEIrJQ/yn2+3T74ja5gtR56tGmnKudLVmN2IrpiU
 0MMe9pOu7eZ1m8XSJ739fLNbvWb1QT6PoCRJEpL0vloExEibhSYH12kyvhzmkaJfrgT5
 0uFJwlz24hhma1ZGSiNWoGB9nWm0zmLGRY68JI2D+h4kLK61oiDwuCS3tDIS0pwJVuDS
 EELKiUT5Z5LEsvjm0r9v8yCR+vmV81jm9RueaAWdrvOA4Grw/k/89PALxUtJOTiz68H1
 Iblg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWa+1QTUFGS1UtPOGSFkRCgq5WK5Pb/tiMQ1Yc/0/UL70KMzo/alrItguX/spI8DQTSUAE=@dpdk.org
X-Gm-Message-State: AOJu0YwJq7lRYpbJ0iBDoMId9YcAwGMoD9mnlixO6UE+etGGOSIoPfuI
 qc0q4O20AtKJWDHzc+U21X/zxQweBS1qFMW+8//SJVcgVO28X5VxHJuH8Y+wad2rY6M=
X-Gm-Gg: ASbGncv92lUxI2AM0P5Mo0/YiIc24ZQLMwAWYch576HoRT1wmGTD5EEE11WvCfRGno0
 /HBLK3eleYzhuObyQvn/doLqiUiLHeE0u17gGSGAep/wQR4jM/Wp/Z+5CR457qKtKa4CEiVGupF
 JtA0TnSx5etnv1cTEDcMxTjqpR4vXgRkOG3coXcFMksUCoROxtdZuZ9mwRNMzEfC1dZzq3jrJ8S
 owcYrHumTshjP1jV4mNPo7mREz905x2he5DcmvTBhX1q3tzwRBS4x9lVkdFze5sfhyYM26p/o09
 Nlbt6nBAFuROJavklQOZiEDfAC4baS3+ZuyBkNkSJcqIbdQHLIknW3bD3H0MDlEm8LibEpRw32I
 erNJoYPsBv+XeQzRHmMdZM4ccl7p1WiP4v/NojEEovmg1k+Dbn9ywvUgnJmxsYj8o9IHz8zUCi4
 /ggc/c/244afg5pjCtWfbKmCvOZU/d9S96JA==
X-Google-Smtp-Source: AGHT+IGiF19QvcG4F2xUDGoORo5Cf+h5b/cSZ/s/LY6H8dMRjurqlZv3FAOF5wdnUnZ6vGmgZTlqkw==
X-Received: by 2002:a05:6a00:2d10:b0:7ab:3454:6f22 with SMTP id
 d2e1a72fcca58-7ae1e6c6956mr6542556b3a.16.1762392298973; 
 Wed, 05 Nov 2025 17:24:58 -0800 (PST)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7af82204ecbsm739874b3a.38.2025.11.05.17.24.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Nov 2025 17:24:58 -0800 (PST)
Date: Wed, 5 Nov 2025 17:24:55 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Chengwen Feng <fengchengwen@huawei.com>
Cc: <thomas@monjalon.net>, <dev@dpdk.org>, <aman.deep.singh@intel.com>,
 <liuyonglong@huawei.com>, <yangxingui@huawei.com>, <lihuisong@huawei.com>
Subject: Re: [PATCH 0/2] two bugfix for testpmd DCB
Message-ID: <20251105172455.5ecefde0@phoenix>
In-Reply-To: <20251106002920.6162-1-fengchengwen@huawei.com>
References: <20251106002920.6162-1-fengchengwen@huawei.com>
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

On Thu, 6 Nov 2025 08:29:18 +0800
Chengwen Feng <fengchengwen@huawei.com> wrote:

> Two bugfix which found when enhance testpmd DCB function.
> 
> Chengwen Feng (2):
>   app/testpmd: fix invalid txp when setup DCB forward
>   app/testpmd: fix wrong Rx queues when setup DCB forward
> 
>  app/test-pmd/config.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 

Queued to next-net
