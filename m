Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD5FC61DBE
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Aug 2026 20:50:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0404040268;
	Wed, 26 Aug 2026 22:50:27 +0200 (CEST)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mails.dpdk.org (Postfix) with ESMTP id 67A0140264
 for <dev@dpdk.org>; Wed, 26 Aug 2026 22:50:25 +0200 (CEST)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2d6f9e2f681so15391425ad.3
 for <dev@dpdk.org>; Wed, 26 Aug 2026 13:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787777424;
 x=1788382224; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=eKUjImA/tqIC9NuaQouOeyre4jZ0+q1ZLFXP1TbqPrg=;
 b=EUPNu3cnR3J7WGpt1ldobHiax6XCP2llsd2JwFXr0PcPeX2zRGNna1+rOe7V+cOkKi
 A0E6oLzygYUwnzbtcs6dbarsyzK0QrG9EhmXf6e2EURxJyFuk5JybI0wqJbrrvpXuThN
 JXnG4qRup1zvLNcNOkLKMi7nJokTzwc+6DZjCmo3PfiKS6BIQTfFee0DRA2jrnyLf9jp
 ezaXvToXvMYYvMlDWsdm4qKD0tocVnZ2R6XiKGCvTMnCxqqztwFbVSezz7YQOPUpkM6O
 F4Qi1TY8xFzdlEJxAhbEcy+rlfS8SsLwvTF5/QS//GRbQUjKnfpYXyBQB5cYBTA4pbxj
 LUyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787777424; x=1788382224;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eKUjImA/tqIC9NuaQouOeyre4jZ0+q1ZLFXP1TbqPrg=;
 b=BodKk5QAlPkSEfA6cnJLdk/4dEbuqn4IVo47IC3+ofqyIYPMWEOERbCtHYqFvWxPuz
 7pR1OiMt+if1jpsM2lWMj0FDCZJxY5CrTagygwGjwYnr6vW5/fSwXytyKAyTsdeWVMdw
 oc0eVYt9hBa1UiPKYCJi8X+pgP19V0qArW8rXal/1vkZaT22R0bICFSbw/AjgKrlyjb2
 45DDKdyYfDjOWW2zYsEFEXjY1RvQ7zPdnlcYHVAp5pBHQK1JFeCKxi+8jMKB83phZHV6
 9wlD/qvFOko1CVFsrCr29cM8AL9oU9hLmBID50V4Gl8mslyQS7RSLycoLJTmNunYgqyR
 Ulpw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpbtzkXPH4r77sUOD642xp0HZCkoVsnjx3CY/RX/eLAbMTtDv8HuL0RtRoTPx6UMYTXiMc=@dpdk.org
X-Gm-Message-State: AFuF++k6ePJ08KU+1QSNaZVyQWZw+Eyj6rZEDQqE87VUouc8e7yYkLWy
 l+FTsaglxIj8pxoi3I4IcWZHaI+HJgZdOAigmebxpjPxjTY8Krt5c95Fgx665vo/CcM=
X-Gm-Gg: AR+sD13W79YVSBGggduHXWWJfh4tH/WEttFd+m6Jv/vV9vrMBDM7jeHrZEoZJBzzKGy
 XmJ1/PulCP0LbkLbcx9ZwDA3xSJoW173Az+CFzO6O65myd6iTXJ1yFQsNkaPCANywN62+NK6U4E
 F5/fjZyq6MZGTxpUhIJqb1LeDPj5R5rn3Ls0UwEaqGQVn3pBJdStDWMejdFQum2WABxyaD8nPYP
 yPwRgQgfYc0lpIYefx+3vkRnh3g9E00gXD1AJksqYoD6JbvTkJhHh3edQzBI8wWFQDaqDKruGK+
 UAzEv+auklwW4Cmx/ym11s7fplisoKFWgvci4zVo5QQ4tP7BqaEnoShpyaQUbf0CBQv48qpJLYP
 WSmBNlhOqm0AThYMDF8PZ+ybXK+96hSR5frLCj6kQbLQYESJwnwv+2kCU6r4c8V6+enixVjBrY5
 i9ca2pxtwT4R/LCe37kgCZtEiTNREbwMla9NqipJH4jQ2tzmAh0PQPYk/KlmYT/wUd2NfLJJr19
 hdq3m09CUGK8w7j2dhfB6P7X47SqLA=
X-Received: by 2002:a17:90b:4d84:b0:37f:c22a:c188 with SMTP id
 98e67ed59e1d1-3966d1af96bmr19407215a91.4.1787777424555; 
 Wed, 26 Aug 2026 13:50:24 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39645d993d1sm9399375a91.15.2026.08.26.13.50.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 13:50:24 -0700 (PDT)
Date: Wed, 26 Aug 2026 13:26:30 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: William Bland <blandwwa@gmail.com>
Cc: Changchun Ouyang <changchun.ouyang@intel.com>, Huawei Xie
 <huawei.xhw@alibaba-inc.com>, dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH v2 1/4] net: fix VLAN insert doc comment for shared-mbuf
 error code
Message-ID: <20260826132630.156eaaab@phoenix.local>
In-Reply-To: <20260826173842.1298754-1-blandwwa@gmail.com>
References: <20260826173842.1298754-1-blandwwa@gmail.com>
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

On Wed, 26 Aug 2026 13:38:38 -0400
William Bland <blandwwa@gmail.com> wrote:

> The implementation returns -EINVAL when the mbuf is shared or
> indirect, but the doc comment inaccurately stated -EPERM.
> 
> Fixes: c974021a5949 ("ether: add soft vlan encap/decap")
> Cc: stable@dpdk.org
> 
> Signed-off-by: William Bland <blandwwa@gmail.com>
> ---

Applied to net-next and I fixed the pre-existing error code formatting.
Turns out you need two '-' to get it to be processed as bullet list with negative number.
