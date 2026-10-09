Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E16CA9EBE
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Oct 2026 21:59:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ED25E40274;
	Fri,  9 Oct 2026 23:59:30 +0200 (CEST)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mails.dpdk.org (Postfix) with ESMTP id B191D4026A
 for <dev@dpdk.org>; Fri,  9 Oct 2026 23:59:29 +0200 (CEST)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2e86dce4510so880235ad.3
 for <dev@dpdk.org>; Fri, 09 Oct 2026 14:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791583168;
 x=1792187968; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jdCDfpwOaef2TJxSFTU2YQHwm1ZNjMyCNmoucccCOwM=;
 b=ZiR8z5xJ5b3L9+uPxlkEeqCQ1VXzXnG5Q1j8aTcZmFta25Mkrkt+g4pgBjTZ6Yz9VV
 Gkv5dV5SwPmackCdqvhwwDvkH98zoZ9kw8cpsWKwgZc+ALBTmiDqBstqkCWi3W2cjHH+
 dycLYz1emZiSpM9sx0hVgGJrsgHgwuaIMUaDky0Lmq4UrkRZgkb0lGfwdyCqaSh8nI62
 QNM/NpE+WejNYYyeNky6pBvVqqbwT2YBD8Wz8sPLBXa9vPvtWeLWv3VLKmS0jLcVDtH8
 7nUcPYco7gJnrPvVF961DOKnX/SFIiukzFvXCqt5/ZbrcgfkigudMfv5joT3cFZIc+eQ
 MWXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791583168; x=1792187968;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jdCDfpwOaef2TJxSFTU2YQHwm1ZNjMyCNmoucccCOwM=;
 b=lrYUrA/44N/udxVB1po3lqPzIvf1ZM7x5C76ygPWwjo4hKi9/1lBrH03T1OJdN9d/L
 xjIyHESbuOAbOwSrWvhp8Q3W+7Z0VRiam8FsuVkDbOpRyt8uSvkMUX4FbDKrtAmjMYMM
 liXDMFsc2wT54h8yiwWZAt31TIbjDlmieTmol5dTLAYKopUp7gprfDLQxj0x0Iy4BPcJ
 j3P7a38mChgH8VHCn+EBZfh+9GxU9Pw7215n2a7b+xqx8K0lSbVdrqYm2sT9Q3AClhAK
 QwTdGhyekAWdrBAgNXzdCEjrNVqT0dH1yI1TChmsO4yqicWX3BZTBqu3jUUZSxA5tOrP
 M7sg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwn94eDHMh53Y6cUakLIKyNstzp4pSorC2wTrLMrMHk4cpMQSOhM0pT3yflEUpX9ZNabNI=@dpdk.org
X-Gm-Message-State: AFq9FYL9L4oKpP0V67OClWRWRfqoJ2uchWZz2ZZidV/CYeaYSeWS/EpC
 wSnGTTz6ZjJmSPAVc7PEMOgQ5JUF93Wj+HNNHZHrtbKyYXFcFeIGgNZjM5bnA+nDYgI=
X-Gm-Gg: AYBFou0b95QlF6fGP3gbtzK2W0N1UuWfkF6fU+4RFlqcuZZ6Nb+EP2xbAZ3ZJbcCWde
 Dcw8t0tCXPcafLtANEVwwGJpoSBn/Pbe9YvRqMXI004hA3uSaLWj70FQd52xlB87U5zpUSKVhYj
 wQe96JOiCqjt3rT3AqDVM7dJSKelKc3x9T33uOy3z7w6hldNjHAXpqh4zgU2ooE3XByjZBFaZ/r
 Q1+2DthfUnBC+bBBPbG5Y6RzMi4inWom0XY4W8TGEx9ZeHD9BZHMRcgXKhrsKbJhSxLfC6yYESc
 wu2K0r+zT5YQEeUJcKRUgdOm+ABqktoBk+WFFlHYLy6DIsQIjl5NJUfZgUOXH94QtFtPhp9QfZT
 /dRWCv7dAaMGsgOUvjAKp+2bqCozxA6lxPpQvY+xk78XTHE+PGuxuPglDbQBRCJHw4e+sSr8dha
 VEx9MmsNg9zak9LgBoZm5xSNVaScutr9UOhK9eD5wO9yxKakjBOMN7koKWs0GW9SIYZShG3pKiH
 fDYeUqkgFLPRGWK3ebRDz5fgHQHxZlglaLp1RebCIQjx/TUWtY=
X-Received: by 2002:a17:902:cec2:b0:2dd:ad73:c98b with SMTP id
 d9443c01a7336-2e842bcda99mr24123375ad.35.1791583168380; 
 Fri, 09 Oct 2026 14:59:28 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8483c3dfcsm14526845ad.24.2026.10.09.14.59.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 14:59:27 -0700 (PDT)
Date: Fri, 9 Oct 2026 14:59:24 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Thomas Monjalon <thomas@monjalon.net>
Cc: Roman Khromenok <roma55592@yandex.ru>, dev@dpdk.org,
 andrew.rybchenko@oktetlabs.ru
Subject: Re: [PATCH v2 0/4] ethdev: report module signal status flags
Message-ID: <20261009145924.703c0db1@phoenix.local>
In-Reply-To: <QfuRvLIpRPi5pHmcYtqGrA@monjalon.net>
References: <cover.1791447600.git.roma55592@yandex.ru>
 <20261009112259.2bd9debc@phoenix.local>
 <20261009192113.534604-1-roma55592@yandex.ru>
 <QfuRvLIpRPi5pHmcYtqGrA@monjalon.net>
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

On Fri, 09 Oct 2026 22:34:37 +0200
Thomas Monjalon <thomas@monjalon.net> wrote:

> 09/10/2026 21:21, Roman Khromenok:
> > On Fri, 9 Oct 2026, Stephen Hemminger wrote:  
> > > Applied to next-net.
> > >
> > > I wonder if the eeprom really belongs in its on library, really it is not
> > > part of standard ethdev.  
> > 
> > Thanks, Stephen.
> > 
> > Agreed, the decoder does not need a device: it only parses a buffer
> > and works without EAL. Only rte_eth_dev_get_module_eeprom() and the
> > telemetry command are really ethdev.
> > 
> > If Thomas and Andrew are fine with it, I can send an RFC for 27.03
> > moving the SFF decoders into a small library with its own API, with
> > the ethdev telemetry command on top of it. rte_eth_module_eeprom_parse()
> > is experimental, so it can stay as a thin wrapper or be removed.
> > A separate library would also be the place for CMIS (QSFP-DD, OSFP)
> > decoding later, which does not fit the SFF naming, so a neutral name
> > like lib/xcvr may be better than lib/sff.
> > 
> > I am willing to maintain this library.  
> 
> This is specific to networking devices, right?
> So it has to be linked with ethdev probably.
> But if it is not specific to any driver,
> we may consider moving it to separate library.
> I'm not sure which place is best.

Agree. One of the concerns is that meson can't handle cross dependencies so it 
needs to be ethdev -> eeprom (or vice versa).
