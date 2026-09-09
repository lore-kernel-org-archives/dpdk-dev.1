Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2AE9C79FB6
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Sep 2026 20:43:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E2F2B4067D;
	Wed,  9 Sep 2026 22:43:05 +0200 (CEST)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by mails.dpdk.org (Postfix) with ESMTP id B6A3B4067A
 for <dev@dpdk.org>; Wed,  9 Sep 2026 22:43:04 +0200 (CEST)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-cc4aa0248cfso721887a12.1
 for <dev@dpdk.org>; Wed, 09 Sep 2026 13:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788986584;
 x=1789591384; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ALu3eVV0n0Pk0Pa87vVjfFPgpslDG9hF3cgKAVVPETU=;
 b=Ma8aQkAzrERicX9VCrfNpUa0GY3qo7J1T5buyooI8rEh0lzzxjwmXqx8VJ+uAul09C
 p9wOEruZmTEeN3B2yKaTkH7ndaVNM5EoV9unPL0dmBMWPwh4N4Lk/7KwclkHkgpQ+rXv
 Lr88M0RNapCxBhZ7di54veMtm7M/+ScDHeXB32Lu67GGCH2+UIVPSTOpkQ8a6zHCdeEJ
 5uosvITciRPCIoSIceKEeN9fbM6p4FPMpuoFVLDFP/kHOVGjoMxgC5VDEoSd74Eyygfn
 5Hn+28ARsdDQhElNBrtFdakQ7LTCnfP3+hnGdJKp/1RT1tHqjv2oEHuiQZW2OTbYDNyj
 s72Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788986584; x=1789591384;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ALu3eVV0n0Pk0Pa87vVjfFPgpslDG9hF3cgKAVVPETU=;
 b=OMMN0wMdOfXlntHHx/edMbBq+ogfP7mHOxutAcYfufYXXMcTpHbxE6zRsyvo8AkBOM
 k/XaWbmEr0K6dEgf5ZvkbNh3lw9CChZXvIJqeh8JXWDYxCp62EZZp+JsGuZHydDMqLb5
 SDPbH+WBWvZuVWLGRW257NY9HFG79jsyBt1bVWRRIaup/MyT4MBxP8dkVxbAWF2jWoz0
 P7VZeaNjC+r3K18BoujNYh93KVBS/UebIX0xmhvQ6Jc4zEXHoC975dQ3odEFe/+G7+Bo
 IkWegri1SBw9M8Zs6h1ta6uh5QL5kR/DZvtUguJbJyhRhuDPWola5WsJy5tBKXLtS2oN
 tLzA==
X-Forwarded-Encrypted: i=1;
 AKwUvBykNrzCBq9UCn/rRg/pUN9syS0mCkRyZOPFdgKIy7eePNlj0vwjqI9ze0wm0/9jEne0CYw=@dpdk.org
X-Gm-Message-State: AFuF++lgeb9Rgx3j/f0szVjFzEqz3bz0u6jA61JeKzO66VCFSYnrmkiv
 v91MzbD0K8oKPCutBSmi9ynvFqpjVvssSYEvFw12Aj4TnW9ndZK72C7n0T1FedfMZYU=
X-Gm-Gg: AYBFou0w9W5rMKnTVO0xApuE3Xk9GAmfiQtAwHohX9s490hWRTuwaIMDXljWLUqRKRg
 iar/mleTBEU1EEzIXB1CvyLkMqk5xKNf36hYfm3XBgwPzZwWG0fYEcSfCQa+Ya3FImO3cT1aJ0Z
 5QA4C6KSncCfW3QoQTNTvz8TFsjeViqfgvOTw/9QQqAkH4NQ2hj/7xkfEtQH0SWCKQtb74/ppuK
 LdMtfdtvVEu9V3hwwXVZNQWOUYxURetXlk8kXlQn327MsF3M4m8HwqQzBDTuLa10HHuhJ9rUyTj
 jGlRZya+vAmtuR1PlhkqWsl0sXMW7zl3WxauBRUyzHOfMIoVvZ3AjvgE6oZGR2ohvfbkxcX3jXk
 ZpJsNdcyvDQKtCA7u0wKiddmWIx+ZPWNhMxqP+66tUrPUhEqszon2cIMnA39Ev/uq+jS7AeN9oq
 VvybLPAdauL+N6YJN3hNziO7LVgPfA4WpWUQsOpkHKPwwsM1jA2eyMfWnbG7/JPBgEih3Y8r6Ii
 AmWz14cAktMRYKIYoH/y2dhDaBXCDTwVXRum2I9UPiQahEAR/I=
X-Received: by 2002:a05:6a21:35c4:b0:3da:b089:dba4 with SMTP id
 adf61e73a8af0-3dab089fdf0mr14021862637.2.1788986583774; 
 Wed, 09 Sep 2026 13:43:03 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc455406f14sm7571292a12.5.2026.09.09.13.42.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 13:43:03 -0700 (PDT)
Date: Wed, 9 Sep 2026 13:42:51 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: "Randy L Tice" <rtice@cisco.com>, "dev" <dev@dpdk.org>, "stable"
 <stable@dpdk.org>, "Thomas Monjalon" <thomas@monjalon.net>, "Pavan
 Nikhilesh" <pbhagavatula@marvell.com>, "Shijith Thotton"
 <sthotton@marvell.com>, "Nithin Dabilpuram" <ndabilpuram@marvell.com>,
 "Kiran Kumar K" <kirankumark@marvell.com>, "Sunil Kumar Kori"
 <skori@marvell.com>, "Satha Rao" <skoteshwar@marvell.com>, "Harman Kalra"
 <hkalra@marvell.com>, <rbhansali@marvell.com>
Subject: Re: [PATCH 1/1] drivers: fix CN20K mbuf size truncation
Message-ID: <20260909134251.2530ab29@phoenix.local>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65A3A@smartserver.smartshare.dk>
References: <20260909160637.3607104-1-rtice@cisco.com>
 <20260909160637.3607104-2-rtice@cisco.com>
 <CAOaVG154GgZGQ56nGujW-bOUi9HYU9T0pqUQVMHyNHYu-1ayqw@mail.gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65A3A@smartserver.smartshare.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Wed, 9 Sep 2026 20:18:02 +0200
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> There where there already.
>=20
> The patch only changes the size of some local variables.


Agreed, I am going to do a tree wide fix of this.
