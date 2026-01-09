Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE29DD232C7
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Jan 2026 00:23:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1988C40281;
	Fri,  9 Jan 2026 01:23:35 +0100 (CET)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49]) by mails.dpdk.org (Postfix) with ESMTP id 299E640279
 for <dev@dpdk.org>; Fri,  9 Jan 2026 01:23:33 +0100 (CET)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-47775fb6cb4so21087815e9.0
 for <dev@dpdk.org>; Thu, 08 Jan 2026 16:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767918212;
 x=1768523012; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2xHfBcz3W0efQi44iRsQMmkhspADIMI4rFhHb5HUAiM=;
 b=mx/VrYdiTsK+zaf6TKf8U2onUn0bax++LN195QhqsuzfpdQvNm27hxOPOXuzfFalu7
 Ee7QZQjegpBYPRsPSheloDBbCT3NuaHxxkg9LlFxFaW/kvTpxHj08vRHcSBAbNpkXDoW
 lBpfL6TrxvCLBiPEhiMKLtzjwaQpGW/aHT9R5Fij2apy+W/74qGTSf6/QKf4IHWH7ufk
 xhk6g6WhK8uYw73u1LbCdScizCU4qJk4DnG++EkFBqajhVcIZCd2tn455H1uRNDfI58t
 iKVDD+OZ/2B9hbcgcUFDCOK/rH/vRI0t19gJFldF4i1B0XKa5c++kNYpEfexwbNVIQvH
 UslA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767918212; x=1768523012;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2xHfBcz3W0efQi44iRsQMmkhspADIMI4rFhHb5HUAiM=;
 b=azaD5hSLtDyFJ5AFCGkgO+xXTQZW7sgLE6qo9hu2pgYktFp9SmhumQLdPEhnOKh/3c
 lhX5iN92HHY/X1a8Ld0QviigJoygH6Bd23RXtv4cABfeDV4jkXhIFUF+RhofNqeRbtPI
 9sM3NweII2Fx8kPPTu3qyClw+2yDIMLYQiRIPXU+oATiotshe9o1N0HDfc7TJIezINI4
 mW/P1sS961wgloKD4lJ6aFRyRtv7tqfbJ2IkVsZzxCSuIQ3dC8bbsoiJokYkeD3F37o6
 shmur7mPK0o97jgW27rkl2ol2LjUs3ABxzS8Wmq9vK75PHfYH8HsawIWXUWA62nI8+hw
 P9/w==
X-Gm-Message-State: AOJu0YwzHKC3e5UsGsxuS5S+NkSnVUE7r0a4lIuB7uDerFrxbqQ5n/oK
 xygZCzwPrw+BgvgihCosnWVC18SEakqVBNOXH42QO4LZmq5HN9ngu4Hh2dHZ6wozC4o=
X-Gm-Gg: AY/fxX6y6xeByUgofXvqBVQxGZCaes4+89EUhI9R85CnMNCB0L/noyC9IPHJG36vBAC
 fTr0snBaRqKjQ+D2XQoLshmLlLuSCKCIuTFfKrEyak3vYo4iSLDzu7fvOZj3wl1JrrFgWTHWRBL
 hRFgG7vpAunXr23jfIMeejsTBv/jEFyqdPof52tYjo5cc1WICc370zlsHWgQjYCIMr8hTnuOgs/
 MPV+rVRYEpAbXoi0dpL/qt5v58MHIeKG8X289ZnDNqQluxbVgIyKUsRaPV2AGoldLNo1LpixGBd
 zRaFUI8A8VkmdklkpC4Uq/s9qal8QyiUWtrS5l9Wqs+AqowV0nne+quflWYHsCm2ytqaEWpKeC0
 O4u8/SRhYriCMQfLA/eLP4DIN95wUwxqDfjJSgjNtmEY3wqPkZ4oILRrcCO2ZNWCB/02vzZW7KE
 LJ10E4NEOGBTB7EjnslE3GtC03SnNvzdlDCWZJctr26de4DjzWfsDn
X-Google-Smtp-Source: AGHT+IFBH10rQ3aYn3m0F8VPsUnrii0HoCjJevS77arweMwK3MP8tARwxZPMv5Ga/pe+jtSktt/KxQ==
X-Received: by 2002:a05:600c:3556:b0:477:63b5:6f3a with SMTP id
 5b1f17b1804b1-47d84b3bc7amr82464385e9.27.1767918212328; 
 Thu, 08 Jan 2026 16:23:32 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f390a69sm178015985e9.0.2026.01.08.16.23.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 16:23:32 -0800 (PST)
Date: Thu, 8 Jan 2026 16:23:27 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Marat Khalili <marat.khalili@huawei.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH 03/12] net/pcap: use bool for flags
Message-ID: <20260108162327.3c4a95dc@phoenix.local>
In-Reply-To: <4b0f415322e2457d93b695469847b113@huawei.com>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260106182823.192350-4-stephen@networkplumber.org>
 <4b0f415322e2457d93b695469847b113@huawei.com>
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

On Wed, 7 Jan 2026 10:28:32 +0000
Marat Khalili <marat.khalili@huawei.com> wrote:

> > @@ -1180,31 +1181,29 @@ open_tx_iface(const char *key, const char *value, void *extra_args)
> >  }
> > 
> >  static int
> > -select_phy_mac(const char *key __rte_unused, const char *value,
> > -		void *extra_args)
> > +process_bool_flag(const char *key, const char *value, void *extra_args)  
> 
> This function probably belongs in some common library. There is a similar code 
> in lib/argparse/rte_argparse.c and lib/cmdline/cmdline_parse_bool.c that might 
> benefit. Having some tests could also be useful.
> 
> I would also think of naming more, word "process" does not really convey much 
> meaning. How about "parse_bool"?

I just went off and tried that and it ends up not being that good.
The problem is that the place for common code in DPDK is currently EAL.

But if you put bool parsing in EAL it creates a circular dependency
since EAL depends on argparse and kvargs. So can't use any new string
parsing there. Cmdline does its own validation so common code won't help
there either.

Good idea, just won't work.
Going back to just 0/1 for now.
