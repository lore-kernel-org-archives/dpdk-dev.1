Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C64C71159
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Jun 2025 00:22:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D7C95402EE;
	Tue, 17 Jun 2025 02:22:19 +0200 (CEST)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43]) by mails.dpdk.org (Postfix) with ESMTP id 5619B402CC
 for <dev@dpdk.org>; Tue, 17 Jun 2025 02:22:18 +0200 (CEST)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-3137c20213cso6175962a91.3
 for <dev@dpdk.org>; Mon, 16 Jun 2025 17:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1750119737; x=1750724537; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=O5NMOX4p85wG2BbtS8881RLmyp/JraPA6yv39NDSNeo=;
 b=U4my5o5NYnWIVtgTm0PRwnZeVqfYhRf8EDn4Ws9w9JBiwL+xLmJ0U6qTQUkg75WUi5
 tbg7WuJgL6eMeISNsyz6Wi1JWA1MPbhYeA3vHfDGeJDywPx0QBpNNHpBwVQF2NTbf0Kq
 PS2ggz7UHxzBlgAWOQuFY3kOC9GECztOvLSZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750119737; x=1750724537;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O5NMOX4p85wG2BbtS8881RLmyp/JraPA6yv39NDSNeo=;
 b=TB/dpjeGt4FcXKZ8oAKtx3cMa/ArJv5FjWtVdawcKTWN50rJKQDN48g/rGeaieIAPc
 Xi9eWDIk2rPL5hTmwBcccGKe356Y5Wjgq9cT7Bn5nF+0AVR8K+mXpXuaM8z21zZqB2Bs
 VTGzIHbgHECOaUKu+JeCnggySTO2qRg9X8pZvJR/f2UzKPOjaSTh6sIa1nrSmq/8KIkG
 Yc6tPmMTucuCOpYgTURFUbtgvOAfOxr2SdfEShterE9ikQGlAYX01wIabQy4ZA3h0G9s
 itJSM63j9PKVSVxUJz/0UFExk0UlD+yP0UAxaNF7kTAe6FJYbtns99hHmL6ZPXUqyUMN
 uAkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrv4hPp4bFwcxkm16ROAxxRLa9zW9kQS/+quKF3WyCZFr0ny+VugZ9bmf9cLbZ7f2iPKE=@dpdk.org
X-Gm-Message-State: AOJu0Yw2ZsDhHBuXr//yDIV/oTDXTfZKEinaHW3yDzGBd1BujoLOlBIe
 qjfjv3rx4DACmob/VuudXxDROBPIucGQZvcM4+AHTo2nhKYuIgt2+/S1w/onW9m1upQDHhh+ws9
 jrZwMePutcJRjWMSLl/7uDH1P7gGy51TIIgUbEx4nyQ==
X-Gm-Gg: ASbGncu4+mLvjxebMumWHf6kzrQgSsNEg3t5/s8aHw4M+0iu02kLW+RtO+k36rllrhU
 kVXgc9LUiQVzADOgeVBJEubFji4uByZF7iSiFObMSh7E3MKUTjWGkeJVERfs1X9kA2HpscUEgqt
 UwROyRiQ/NlsHAxi/sSt6SD3ysLhFZyYxcAKUYSQk250SmEC2WCFW2EvUmo+pEJKgmKAda1A==
X-Google-Smtp-Source: AGHT+IG0eFFyV/tFhnL8u7kxGOyPQTK0/j+jNkffXBskB72Kfj6QBfaFhz206IAFtnKVUXqP+xhpuxsLdnotd7MJbAw=
X-Received: by 2002:a17:90b:5584:b0:311:fde5:c4b6 with SMTP id
 98e67ed59e1d1-313f1be98d2mr15635966a91.6.1750119737336; Mon, 16 Jun 2025
 17:22:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250612201220.614724-1-dmarx@iol.unh.edu>
 <20250616183859.646384-1-dmarx@iol.unh.edu>
In-Reply-To: <20250616183859.646384-1-dmarx@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Mon, 16 Jun 2025 20:17:02 -0400
X-Gm-Features: AX0GCFtM5LX9COlY7JH067FpPeozBc_Zdd-wMMzdljXeRzWPJJodeQf1STxP9UA
Message-ID: <CAJvnSUC_=euqk5aYGgLTu=CsDgmT2Bgrd=vcX4XG4oLmvG_YZQ@mail.gmail.com>
Subject: Re: [PATCH v2] dts: fix devbind initialization bug
To: Dean Marx <dmarx@iol.unh.edu>
Cc: luca.vizzarro@arm.com, yoan.picchi@foss.arm.com, 
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com, dev@dpdk.org
Content-Type: multipart/alternative; boundary="0000000000004242710637b9815c"
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

--0000000000004242710637b9815c
Content-Type: text/plain; charset="UTF-8"

Recheck-request: iol-intel-Functional

--0000000000004242710637b9815c
Content-Type: text/html; charset="UTF-8"

<div dir="ltr">Recheck-request: iol-intel-Functional</div>

--0000000000004242710637b9815c--
