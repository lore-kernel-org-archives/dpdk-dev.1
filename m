Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E9BD10397
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Nov 2025 09:10:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8B02D40A72;
	Wed, 26 Nov 2025 10:10:24 +0100 (CET)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by mails.dpdk.org (Postfix) with ESMTP id 11A76406BB
 for <dev@dpdk.org>; Wed, 26 Nov 2025 10:10:23 +0100 (CET)
Received: by mail-pf1-f174.google.com with SMTP id
 d2e1a72fcca58-7aad4823079so5714314b3a.0
 for <dev@dpdk.org>; Wed, 26 Nov 2025 01:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764148222; x=1764753022; darn=dpdk.org;
 h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=M9QVKsRlQYs0dbh1UHFXq8FnPRfZhIz/H39Lb4kVDFA=;
 b=PQN5Yny3aycILNGhcSSfLbQ8Hw07yW573uXTs5PAP9ylMAg1QBYvvUdjCPscKt4GsU
 gQKCQDX9gXFMe5U4/ROKTJk01++Wmlx/Cvlq9jZHwkzH1yulvrWbIs3zEHIxzw2rBT/c
 29wAjQcBM4V4AfXd4pFSGp4Lksmj/kKL9HqwNRUoCujVfNZ0MEtDycVzLslFvjx9bzHI
 n06jiPTZf3roAKtIh5hUvhDJfx0zVlNorrgXGoyNME+1B39FLq2+YiThe7EVgpgkuZEA
 WClFR4y9Zs7m4vtCuFHeYTLXyxcdmgmV1/kwtTWP0lim4QrXFFAgWPyet7oq6I1x7OF8
 3fAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764148222; x=1764753022;
 h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M9QVKsRlQYs0dbh1UHFXq8FnPRfZhIz/H39Lb4kVDFA=;
 b=Gnwo9trJF+ArHHiOdDmh9BndTQROyDLRqW7uOCl9urwAOdCAGD5v6afsWSf+C8/f/D
 CPY7laQluwPROWJH3ekEl5GohFTikl5CEcWvzUUOYc76K5Ppb2OBhA706wYjQ/8gGiJm
 I7D8nZRAgSkPVqk2FdmuZSmGW5WqFKjNbWYStpBBdmqpyRwqUmrvkMw6fVrIG1lKK6HM
 uWFTHylrgxQWj7qhiYniNTkAApbX5ULsxN1jFFtqojhe+T2ORyYhKDhrWmTMJ1q1xhV6
 RXDYBhiIkjWoetBrWQBMu/8r0uPkxjeJ2saPCN5O3Sx+M6Qo2plP3tzmpmUYiQQH5Yum
 6K0w==
X-Gm-Message-State: AOJu0YwNyzDrWzEqvJNdRa/+IcACwNH19jD3Zo4q487N7FwatoUl6W4M
 4Ik5L2WGd+1EijbcSeKeh22oU7PFPa3ngY9IMz2kDcnw2ZBkN2RBPAwE
X-Gm-Gg: ASbGncvnOK/JIKZIDBrDHavYHWMUXEk/UUAGOR+VM4fNUGOf6wcoRAbvInU0ybp7F+P
 kIBEM+hzk9/OoZ4KvZYv+Q40QoNkLxwcXYWfUqS2AdfvllRV5+aPEWx6pnV9a6UPyeV+lCI+NI8
 4TRJ26NAfo5WB0tqapg43IMirtAmM/I4EO1q3QP6MbrTBD8jnDjHQpVhB2mxSZO3jY4m6de8O2W
 RL7qYAun6uoFg+b8LeztO+d5U7xB5F3WLJLLGJN+xtAniir4JQDWMz8QuEia9L6g2BZFea9y+k9
 1qhtAzmvOtY0+VgWWN6vBcErbft+1Zp9O/tlzE45M2JaLZrVHWUn4OgXkQXHTpRCmaj57hTEeRJ
 SNhUs99dG6YOEnaj4GpPWy0A5hfUPI1jJnmcpuo/OtC+Df7BUb3RCA4TqaDwd3nnUaSNwWI0yPk
 MSRBGkVjp3ot7QN7mszb5ou0d7r+SfWM6mApk3Rs5QvOsyfhbwpboVL4ApUpi7/DxG
X-Google-Smtp-Source: AGHT+IH/h54bR/MIWhiRz64EQjxZiPQRiPh7v6qaADUM8dfpVdT2xh4IJ9dpo/KuWx+HfuuCdmJj4A==
X-Received: by 2002:a05:6a00:17a9:b0:7a2:705c:5037 with SMTP id
 d2e1a72fcca58-7c58c89cbf5mr16783387b3a.11.1764148221947; 
 Wed, 26 Nov 2025 01:10:21 -0800 (PST)
Received: from [192.168.31.49] ([122.231.40.249])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7c3f023f432sm20481888b3a.44.2025.11.26.01.10.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Nov 2025 01:10:21 -0800 (PST)
Content-Type: multipart/alternative;
 boundary="------------8ilxu4mm0RFPDjHsVWmy4nqZ"
Message-ID: <b6d3eabc-de9b-4709-b161-337a2bc9623e@gmail.com>
Date: Wed, 26 Nov 2025 17:10:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] net/mlx5: improve socket file path handling
To: Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
References: <20250321132750.4237-1-ming.1.yang@nokia-sbell.com>
 <20250829144954.2576-1-mosesyyoung@gmail.com>
 <20251117095842.496757e5@phoenix>
 <20251118144559.hpcgungifxd2hv3l@ds-vm-debian.local>
From: Moses Young <mosesyyoung@gmail.com>
In-Reply-To: <20251118144559.hpcgungifxd2hv3l@ds-vm-debian.local>
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

This is a multi-part message in MIME format.
--------------8ilxu4mm0RFPDjHsVWmy4nqZ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Dariusz, Stephen, and the team,

Thank you for the detailed update and for taking the time to discuss the 
series internally.

I fully understand the concerns regarding backward compatibility and the 
impact on external tooling. If moving the UNIX socket path from /var/tmp 
to a proper runtime directory requires a broader change across dependent 
tools, postponing it to the next release cycle makes sense.

I'm glad to hear that the issue has been acknowledged and that the team 
plans to address it in a more complete way in the upcoming cycle. I 
appreciate the consideration regarding attribution as well.

Please let me know if there is anything I can help with during the 
redesign or review phase.
Thanks again for the clarification and for handling this thoughtfully.

Best regards,
Yang Ming

--------------8ilxu4mm0RFPDjHsVWmy4nqZ
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Hi Dariusz, Stephen, and the team,<br>
      <br>
      Thank you for the detailed update and for taking the time to
      discuss the series internally.<br>
      <br>
      I fully understand the concerns regarding backward compatibility
      and the impact on external tooling. If moving the UNIX socket path
      from /var/tmp to a proper runtime directory requires a broader
      change across dependent tools, postponing it to the next release
      cycle makes sense.<br>
      <br>
      I'm glad to hear that the issue has been acknowledged and that the
      team plans to address it in a more complete way in the upcoming
      cycle. I appreciate the consideration regarding attribution as
      well.<br>
      <br>
      Please let me know if there is anything I can help with during the
      redesign or review phase.<br>
      Thanks again for the clarification and for handling this
      thoughtfully.<br>
      <br>
      Best regards,<br>
      Yang Ming</p>
    <p><span style="white-space: pre-wrap">
</span></p>
  </body>
</html>

--------------8ilxu4mm0RFPDjHsVWmy4nqZ--
