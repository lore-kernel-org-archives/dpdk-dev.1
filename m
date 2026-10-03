Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C904CA5FEC
	for <dpdk-dev@archiver.kernel.org>; Sat,  3 Oct 2026 16:19:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2AA3A4028D;
	Sat,  3 Oct 2026 18:19:54 +0200 (CEST)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43]) by mails.dpdk.org (Postfix) with ESMTP id 38F434028C
 for <dev@dpdk.org>; Sat,  3 Oct 2026 18:19:52 +0200 (CEST)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-383b4a3755fso349852a91.3
 for <dev@dpdk.org>; Sat, 03 Oct 2026 09:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791044391;
 x=1791649191; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UR0N0AGfF8seRfKhxGEaesLaP9U+RBLDcdovvmgKH0A=;
 b=RZxAb3L9nxh1aCL6u4j0UT/xHaoomuunRCYTFVe2vAhbxh7RzvEs3ELe0xo5wNQf0Y
 Wx2mZGOUXdD3kAV9O8BrqId/pSkeAucBgQMcd56sBW9o2TrHFZyLs74WwpTi2Cfa3Jyu
 p+Md2q2u4VGzpw3rRXMLjn20I8XRW7b0YlZH5IYNdX0nS5NClc2AFGCC3q7Jcq/h3N5Q
 oarG3bUd6bFwsAwJAUlXzcKZKlTY0NI8L2+MEQvASF1BZ7bzSLdli0qjqxRQqQsIpPut
 S6lMdtyYe1MdEUdiyF0fcgIjJnLrH8B7v/R5iSQrAV+ND9OxgMZj3FlA6STT+4YvbrF2
 56vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791044391; x=1791649191;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UR0N0AGfF8seRfKhxGEaesLaP9U+RBLDcdovvmgKH0A=;
 b=Zsp/EHxiHoPL4KMrVGlHKI7Qvr4denLe5nCiTd4EIGkQdb1hLLM3PW46eVEjjac237
 /+EzGUsYcH0XgIpRiSD2k2aOQpmuLyUnUEEv58xiR4eETtIFBzX8hJfAd+6yZA2qRDiG
 I3asJHjAz/x2JuRh57HUlvBkmGzfAigQ1te4ow3IKKanMbUNoVYxqExhfNEEVNvf7n4G
 bmPlDRLMlSBAYm5DJDKCUN/uytZsZt9IWhruhxaOvb81lQcbi1uEmJK3y7ySnmoA6Mat
 Q6ePlPk/2KoKRkxqCZwpO9o/cj4pk22KVHatO2fk1g5r5RzEV41asQhnqzvESodqadwk
 SDSw==
X-Gm-Message-State: AFq9FYL5XexADZAp3mJ5v7OkNeZmujl7qAX6NlZhwbASB5RraJ8E2cgR
 epTTyL6vWIEBP8+IE/a/g7Mh776Q8jOtKzRddNOJnRvE1ozBmX5+PEuS4EfOGnbvPs0=
X-Gm-Gg: AYBFou3Byxd8qlfWhT32r/opWQqBBugijZxOM0zfOe31ODbHLfmT82SFgZIGIpYMD5z
 XF67lvHYtHIg0+iWaTJBP5jrxCZDWU10H5dkaDOYaBWzUWlo3BzGzBVa8rUvJPxJyxp5tL4Djjt
 ZwNzfPKgc5SzHlQjtz2k0ioeYjG0gO1RvDr1bjakQhaDnoRtyUm3TKehVCiz5xMGSUmpOmUakZq
 AtMYtE1dTTk4UZRdOkfZbBj4uEZKfZ7v88gOdWIFnSWMcZK00CTuW5bXAGY/rBXf45w/yiuoqtU
 KCIDkyKbAJIR8Dq7DuRWhRBClpcUc6Vr1mBLeUrxN1ZIBzXYaN9pw+Hf9isounhhjveExpqsctO
 cBZ91Dk5S2VoGhe1c5of5Jc7DlqDNFlxdvVoM4R/OokmUYKFKJJCg018sn76xk3Kz26tK6Z9xts
 /C/rvEFQQCheUZwk/CFkO5ZZKo2rJB6drN8yfNLKH9uAMhcydwniA905Hkai3N8hd8SdpQWmj1J
 vqa/6zT67HVZaGwdIZyT6ztGbH5qbQuLeaO1u2O
X-Received: by 2002:a17:90b:2cc6:b0:39e:6c69:9b9a with SMTP id
 98e67ed59e1d1-3a787799a05mr2341777a91.63.1791044391246; 
 Sat, 03 Oct 2026 09:19:51 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a78e5fbf30sm3389364a91.16.2026.10.03.09.19.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Oct 2026 09:19:50 -0700 (PDT)
Date: Sat, 3 Oct 2026 09:18:32 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Roman Khromenok <roma55592@yandex.ru>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>, Anatoly
 Burakov <anatoly.burakov@intel.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH 0/3] net/intel: make link state configurable on device
 start
Message-ID: <20261003091832.2ee5b91c@phoenix.local>
In-Reply-To: <cover.1790970122.git.roma55592@yandex.ru>
References: <cover.1790970122.git.roma55592@yandex.ru>
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

On Fri,  2 Oct 2026 21:43:35 +0200
Roman Khromenok <roma55592@yandex.ru> wrote:

> Starting a port always brings its link up, so the link partner sees
> the port as soon as the application starts it. An application that
> enables ports only after its own configuration is applied, such as
> a firewall or a switch, cannot keep a disabled port dark: it can only
> bring the link down right after rte_eth_dev_start(), and the link
> partner may still see the link flap.
> 
> The ice driver already has the link_state_on_close device argument to
> choose the link state when the port is stopped. This series adds its
> counterpart, link_state_on_start, to the ice, i40e and ixgbe drivers:
> 
>   -a <pci>,link_state_on_start=down

NAK.

DPDK devices should not be like snowflakes, everyone unique.

When I see patches like this I think one or more of the following:
  - a user does not understand how DPDK devices work and does not
    want to change their application
  - developer refuses to say no to the user.
  - DPDK devices semantics are poorly documented.
  - DPDK devices do not implement the link states in RFC2863 but should.
    RFC 2863 separates ifAdminStatus from ifOperStatus; ethdev should as well.

If you want something done better it must done at ethdev layer
and you must coordinate across all existing devices.
No more specials.

Take user input as problem description, not as directive on how
to solve it.

The link_state_on_close argument in ice is not a precedent. It was
a workaround for hotplug problems and should not have been a devarg
either. Adding a matching on_start option to three drivers repeats
the mistake. I should have objected stronger then.

