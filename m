Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C52C7EE30
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Jul 2025 14:39:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 95240402A5;
	Tue,  1 Jul 2025 16:39:04 +0200 (CEST)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mails.dpdk.org (Postfix) with ESMTP id D012640264
 for <dev@dpdk.org>; Tue,  1 Jul 2025 16:39:02 +0200 (CEST)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-234d3261631so40908575ad.1
 for <dev@dpdk.org>; Tue, 01 Jul 2025 07:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1751380742;
 x=1751985542; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pp6IJ0XJ5j+JnEZ3oR1pYDD870Xn/3hAKmTeHgA2rBU=;
 b=iOZHUxkPukjKd3qF4+0ctXW7xaADJbIPmFnBve2p4knNrwMNtnnBdRTDASmAo/h1af
 hF1ESvTQGQ28JPhm0FkdHAL2PwvZt4DxZr6FEyjOLXZXkZ83sSh0GqwnT710gF3Us3kt
 6E1GM96P4pS4Sc56XXDrlKk18/gGzwzSGs7mvSu5RBhbxZANZkDHRD7nX2IrS1+fbRM/
 Yu/uETZ353AIXBB46B5e5H5w+Gl5qPwcs8FF8+YfI+jvIA18Teq5XQL3yCPT4Reb1yVg
 5nentoR/NITrbQEDE1ccoblzOeBRiuGE3T7tachRSUO2AFgQKNk239xQTWMby/NB4edJ
 xUfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751380742; x=1751985542;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pp6IJ0XJ5j+JnEZ3oR1pYDD870Xn/3hAKmTeHgA2rBU=;
 b=Wm0wRGn83buf1pQJT+kcIJBnAaCyahonbJHNDvhAKCe0KkqLDIbGuaqVsbXHFt/C4n
 7tPsRuKERiGO7qZlfCp5uB0wCLZK6d7NQTkwpJT/RX6Er4xKk1ezwR33fH8Y8gKj59cR
 Fmadt5UzcUZazt68T+MVxbyodditDcsu0+O2PlVSZjgxzcgvXKiSKBwvcC2FJlfGLJss
 W0dqGS35/0pkEDYC6OLRzTeVgVDK92YmTH1vSQzX1AJ6nEovaaRd6JzYWHqDb+dlE6xL
 iKZ0kCBx3gU2SCqM2SclBKYxss7sKxH3/IKSjnOwklmR0w3oSkEMGG0YlJltpG1i+iUk
 owLg==
X-Gm-Message-State: AOJu0YwbtJoZSHX2U/BMMlJ/O2shYriZnqx9vGl8bUb8Mho9HYBUE+dy
 7bdPaKEXNevpy+aJ5KVSefXURzFyQb2ts/9VxdrlyBqcjBPbvcd4jy17gF+RApZ2PoOHztJ0Ooq
 Ymt3hgF0=
X-Gm-Gg: ASbGncvr2VDd7O3E2DeSVqrQyljaHKeoYwCZ7oQomzZLLYuakpHLvFCUrHwK0f9M8vr
 LKqpeZ9bvZDM5aoc2TOtJRPsNZDodYWryNSplsybb3kZqHDgBzYMnwnISewM9tbSUusRPw/u+ZV
 6TUyovwoClPwhRUiAX0lVYQBpkZ1ASW6FELhqQVR0yDQIqsQ7U+68fv/tukCO7U27LO5XZ6FBpn
 JzXvvxjEwLxx7LiWlKTy9eSEFb5Vg3v6NinDRh3wDi5uZzPeg/tkHLOmCDGEy2lMlLEBq+lIkGg
 phHe6f+D/T9AzDt3T30+xMHDmDQ1ndsjRvxFlEyhsW3e9USe1zr0o3UsGv4T+DbQKf7VMm/aKOd
 fL808Al9URyUGn7/DybJUoAvA9YglsRHlEAS/wTh/pIGJudH0ew==
X-Google-Smtp-Source: AGHT+IGuD1nQ1Uf0oyLz7GCCoWjKxHoMvyvCCI7VdPlaNjDLq2uglu6FJrzc4dn9CFh2ZdAf4z7riA==
X-Received: by 2002:a17:903:2445:b0:234:8f5d:e3c0 with SMTP id
 d9443c01a7336-23ac45c1cb3mr232369195ad.6.1751380741767; 
 Tue, 01 Jul 2025 07:39:01 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23acb2e19cfsm105976645ad.3.2025.07.01.07.39.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 07:39:01 -0700 (PDT)
Date: Tue, 1 Jul 2025 07:38:58 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: dev@dpdk.org, zaiyuwang@trustnetic.com
Subject: Re: [PATCH v3 01/17] net/txgbe: support flow filter for VF
Message-ID: <20250701073858.161dce1c@hermes.local>
In-Reply-To: <20250613084159.22184-2-jiawenwu@trustnetic.com>
References: <00DEAE896AFE0D2D+20250606080117.183198-1-jiawenwu@trustnetic.com>
 <20250613084159.22184-1-jiawenwu@trustnetic.com>
 <20250613084159.22184-2-jiawenwu@trustnetic.com>
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

On Fri, 13 Jun 2025 16:41:43 +0800
Jiawen Wu <jiawenwu@trustnetic.com> wrote:

> +bool txgbe_is_pf(struct txgbe_hw *hw)
> +{
> +	switch (hw->mac.type) {
> +	case txgbe_mac_raptor:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +

This is ok as is, but you could make it much simpler as:

bool txgbe_is_pf(const struct txgbe_hw *hw)
{
	return hw->mac.type == txgbe_mac_raptor;
}

Or are you planning for future hardware?
