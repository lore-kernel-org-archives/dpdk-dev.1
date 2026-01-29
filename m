Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FABD73E83
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Jan 2026 20:14:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F5D940274;
	Thu, 29 Jan 2026 21:14:26 +0100 (CET)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43]) by mails.dpdk.org (Postfix) with ESMTP id C09C54014F
 for <dev@dpdk.org>; Thu, 29 Jan 2026 21:14:24 +0100 (CET)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-435a517be33so942215f8f.0
 for <dev@dpdk.org>; Thu, 29 Jan 2026 12:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769717664;
 x=1770322464; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iK/0CPsBsBPN1Y72y4lH38RGjX0NwMb4we0i1RAAmSI=;
 b=UwXuAnX61XWUktMhRkUKf/ZM4QmZ57cOhzBCrAwEUxJhoXbOJGAXBsuCzZLPHJOZrP
 ob7kxk3o1wgybFLL5y3LV6M6iGz6UehwzKLSf9i1KMIYWA3HUf8tBx+AmTRm1W2JuUzv
 FhE6M6X8HeclHfAV0ifWlm+MlmuwLnBQSFvx3KB/zLb8q6AwpYLvtTZ348ztQq3aj6Nt
 yyRyAxY7lL9blEaZPT/iAHaUHFehb/fu3BcoQxkshC0eArW4+Iv/aIakxKWFKE9FAh8M
 wiFGahIvazc1IVtOksBDtRoWWwD46P7/b+QqGaRlOm4g2MtomAu6Fd3PT5zZONEDVjqo
 ZFrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769717664; x=1770322464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iK/0CPsBsBPN1Y72y4lH38RGjX0NwMb4we0i1RAAmSI=;
 b=kIk03IDCtmj6vxL9IRwRajLVhrhwKFJZ2RUYRR2V71MZ4nOYClGwgW0tQzObt3k1gr
 qEiii5WLCU6Xbv0pSQxt2yBLjLXYS3fTfgSXQvfiiwCI5BDFwiOekY0BbHDZRc6WiVXs
 1YBW6t9402dXadilaqRZHC0vx7FllUMw3g3/ddUdY6FSTaYk0gkwlnw0JawA79O5oiRe
 wZnFWiA5prAciN8Y2+FiOTNl2P8PYo6zdMBz7AmpgYJIB6AHLp/hZTvrRvWZ55R9nc0L
 sQg8PmEKFbOLxJSz5cb6K52E2IFKn+u/O5mYo0isG78yYzM/K5qphj9/qDMSN6eDTgw5
 jY0w==
X-Gm-Message-State: AOJu0Yyrqcg22B6Q0MkHfptZDQMGKH9MdBq/NsVb9nzay0l6137rVpCR
 fxyiRFc9tcdzlI2k/W6zMTPSuQ4FltgzKnl3FPHwtvwK+mvpjzf+1F6OHbfwYWmc2es=
X-Gm-Gg: AZuq6aJsAeLLENxL0X+VvGixnVZSJWRbtLtIqERTTbBbxYlMDYMtccKNT9zIncn9Ree
 yHj3VEXpPhjAVhiHaacWdJZSUEVLZ6Nd137KFUdfX3aEP7goWrQZ5rKOXNGPDanfo3XwJkJAWjs
 EHktAx1JudqavtHUYqKEYOFaDrf5MoA2PJuom9ZqkpVJZxZj2xfKC3giwFDodUeGBvESrzTu5ZF
 tESo0XmP11IdZ/N6pPzWxH7cc6chtmfTuxE83oPgiRUbustYzT4NjbZ1zum32Do3r/x4T7Nx0bn
 7c8JwFYuzMuYZ/bHHTd/KXP4Z5Xsjd2fSi0ohA2kM8rSXG9F1SDEkujh4T0PI8A3xwASmkP8IJp
 N1+Hp2YeAHUgRD7E8kHx1mTN+TerP70g+Qk9RZSGsODGv0Y5mVqpabsmKmwAziJ8/OBC+PI2vcA
 El8Kb7fwMWzaTLCLqDBFIs2cs9n5Jrx8h3Wiwx6MFAFuUWif6Kebm6
X-Received: by 2002:a05:6000:420d:b0:435:bbd7:18e9 with SMTP id
 ffacd0b85a97d-435f3ab5013mr1177824f8f.58.1769717663843; 
 Thu, 29 Jan 2026 12:14:23 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10e483asm15996656f8f.3.2026.01.29.12.14.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 12:14:23 -0800 (PST)
Date: Thu, 29 Jan 2026 12:14:14 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, Chengwen Feng <fengchengwen@huawei.com>, Nicolas Chautru
 <nicolas.chautru@intel.com>, Mattias =?UTF-8?B?UsO2bm5ibG9t?=
 <mattias.ronnblom@ericsson.com>, Ori Kam <orika@nvidia.com>, Andrew
 Rybchenko <andrew.rybchenko@oktetlabs.ru>, Jerin Jacob
 <jerinj@marvell.com>, Amit Prakash Shukla <amitprakashs@marvell.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>, Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>, Bruce Richardson
 <bruce.richardson@intel.com>, Morten =?UTF-8?B?QnLDuHJ1cA==?=
 <mb@smartsharesystems.com>, Pavan Nikhilesh <pbhagavatula@marvell.com>,
 Paul Szczepanek <paul.szczepanek@arm.com>
Subject: Re: [PATCH] lib: remove extra characters ending comment blocks
Message-ID: <20260129121414.6aa40db0@phoenix.local>
In-Reply-To: <20260129144749.3637111-1-thomas@monjalon.net>
References: <20260129144749.3637111-1-thomas@monjalon.net>
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

On Thu, 29 Jan 2026 15:47:48 +0100
Thomas Monjalon <thomas@monjalon.net> wrote:

> At the end of a comment, no need for an extra line.
> 
> This pattern was fixed with the following command:
> git ls lib | xargs sed -i '/^ *\* *$/{N;/ *\*\/ *$/D;}'
> 
> A comment should always be terminated with */
> 
> Extra asterisks were found with this command:
> git grep '\* *\*/' lib
> 
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>

Acked-by: Stephen Hemminger <stephen@networkplumber.org>

Should look at examples and drivers as well.
Maybe add this to the AGENTS auto review script.
