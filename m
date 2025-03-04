Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831DEC282D0
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Mar 2025 20:39:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 66165402EB;
	Tue,  4 Mar 2025 21:39:16 +0100 (CET)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com
 [209.85.208.179])
 by mails.dpdk.org (Postfix) with ESMTP id 8FFC3402DF
 for <dev@dpdk.org>; Tue,  4 Mar 2025 21:39:15 +0100 (CET)
Received: by mail-lj1-f179.google.com with SMTP id
 38308e7fff4ca-30bab0ad5a8so31715311fa.3
 for <dev@dpdk.org>; Tue, 04 Mar 2025 12:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1741120755; x=1741725555; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NyAP2VA/MIHjjHhz5LmUgeqITox+MyqsC3cLZV8wJrY=;
 b=csTPft/VaOfGjSSF6m/g+kr2rHI1LCu0d7j5//lJtw50RQ05wfJMKg08Me0akIWY3U
 umOVbIg6ki3nxc+rHSUXEq0v0q0U3rRVbRWtXaA65wEbkPzBuQlpoKzOEBW6k5VvA4FM
 4HoVCw7YbHzJCW+bNERNIQN1eipwhYqsD7Uio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741120755; x=1741725555;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NyAP2VA/MIHjjHhz5LmUgeqITox+MyqsC3cLZV8wJrY=;
 b=KCDAzTozyvxHuk9dkAy9JMhN4kRX9PjDj/qNc4c/n+3igClveiFESa6t1KrQR57Kh0
 g90DMi0uV4wiTcRmfsTg7eCC/m7KhVYnbHTtPkh7A9nM3LL89XPILEDwR3PEw0Ztstrw
 e+Uhndj1UF7iDz8OeMfGKr8fk2GRjPnkulPq90mSov0pPdZQ6cUhLBp6mNWNE3Mq7HZY
 ++JTi9H8+u+CU5STSmvAozW8OzR7XS/8P8ulQfPDqBN5s2mrniLEpFAZ7Hg8N8BSYkGw
 FMazeS+UyAuJE0rfZ4EaZ8AMVJpNUCSDxh4Sulehsyug7fx+5ze1t72Xvx/kD6kT/GXU
 naZA==
X-Gm-Message-State: AOJu0YwQxEphDCbyRww1dCc1YuNXOUGKnuRobmyyBKsBsG7Xz0XHRMnb
 fqSQWqJtX3YrEzGtbFpSZG3lFDNmPSRSbjLJpGXFk/4bSYY/LUtPQ7ipFWMPDk0N9sxBh9Bl1ak
 fQgwZjnFvAZXyq/Ucqg7kccqogCziRU7MLT3vbQ==
X-Gm-Gg: ASbGncsl4umVgfHGNb11lVzxqY01jh3QMAwCsVpCS7ZY9TZH+/e7+K0tU2mj3WxBZqe
 M/FzTuhZP28DPMg0WgV95hidiV5T7k/7ET3Cb2f6D90Kwz/oVwxv86RnfRs4SpqJ2qLSl7SLQlC
 ORufbfxuv0Ev/byBTVfgDE7k1sRna21/4UzsrpeFAEJHjKjXUsGbG13NLOjV2C
X-Google-Smtp-Source: AGHT+IEvd8kT9kbB8PvUrpNHyI0J2+nC27RxCvxMRycZGuhrWWLBrl83XabDv+puV9tV5syRQ6LZV4vAa4vFocY0R1I=
X-Received: by 2002:a05:651c:b1e:b0:308:e9ff:506 with SMTP id
 38308e7fff4ca-30bd7ae66cemr1955901fa.23.1741120754955; Tue, 04 Mar 2025
 12:39:14 -0800 (PST)
MIME-Version: 1.0
References: <20241108134532.130681-1-luca.vizzarro@arm.com>
 <20250303145709.126126-1-Luca.Vizzarro@arm.com>
 <20250303145709.126126-8-Luca.Vizzarro@arm.com>
In-Reply-To: <20250303145709.126126-8-Luca.Vizzarro@arm.com>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Tue, 4 Mar 2025 15:39:01 -0500
X-Gm-Features: AQ5f1JpsCCi2HHf_9zsDeStLYe-64jMpcoRcU2jydO_wbeKgkY2kisa6P0bLGeA
Message-ID: <CABD7UXOF-WHtT=3B_gQ=6wzJMbwWPBQJ85HFbqB+3mLgBOuoYQ@mail.gmail.com>
Subject: Re: [PATCH v4 7/7] dts: improve configuration errors
To: Luca Vizzarro <Luca.Vizzarro@arm.com>
Cc: dev@dpdk.org, Paul Szczepanek <paul.szczepanek@arm.com>,
 Patrick Robb <probb@iol.unh.edu>
Content-Type: text/plain; charset="UTF-8"
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

Looks great, thanks Luca!

Reviewed-by: Dean Marx <dmarx@iol.unh.edu>
