Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A8AC83F22
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Jul 2025 20:16:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B13A340668;
	Wed, 16 Jul 2025 22:16:24 +0200 (CEST)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53]) by mails.dpdk.org (Postfix) with ESMTP id 09C1540655
 for <dev@dpdk.org>; Wed, 16 Jul 2025 22:16:24 +0200 (CEST)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-3137c20213cso294036a91.3
 for <dev@dpdk.org>; Wed, 16 Jul 2025 13:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752696983;
 x=1753301783; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WxYS3umDHmaIF1qwjPEylGKnTFCiP9k/whEsaTok6w4=;
 b=fzihyPBF5qpPzNVaOWc4VCdOxGs7k3FqSm6a6RHwaaTDgYPVv8Da54RZMNBjXsKSM4
 Ck+9sz+FBqKQi5HXNSWkNFpoJgQXa9AFFZ9CCgKxudFm6sQu1YGdoWU8a4DDKNo3zB19
 AqWrB+F45lMXjxeNW9tsksn01E/JULqm9cWSAxGAKJeIi9JNmJh5yfOxP4/Kn7UjV5m6
 u3kE0nxW/CS/p0OdBUyNiGU/AEB9bgHBXvpA/YElitwE6gXTGt5VGgA2K45wz0//J4mY
 j+Jzv4p1l7sC0zF/B0vFeJI8Ecazs3Vc3fAkhKR+9Obv3k+GEhCUIF9kx4m+5+vOn6SO
 xLRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752696983; x=1753301783;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WxYS3umDHmaIF1qwjPEylGKnTFCiP9k/whEsaTok6w4=;
 b=EYNftcZOJJbEJdQl+nA1ZPgUdke7v4CIs/iwQHw6T8LbxaNZcQsGZ3rSm9yH+1/SIH
 bS6zjeibmJVXEB/OghY3t4zSIk8Am3Zj6V+2+GvebT+TybrR55GpyMbDejb4oTBvwjB9
 JkiYLrYqUBE1lHcCpDyRgJ+upUvTZnI0LqT79udMv+wYGzi2IKy/BvnVIV+JRGiekE3y
 0LxvexZOp//FI1nRPtOWu3Wcj/q4G3kGsG5Qib7vH97bBze4uV/c5Fw+eFPLUBNsyZOr
 S1vikr24m+xPHXkSqJ27CPPKaw4Ln6REqYXRBvEaqKpS4JxQHy0WdEXBqVy+Sl289iDt
 aoDg==
X-Gm-Message-State: AOJu0YyVBkzSJBt9yaRUpH1tfN8iiy5CfTe2pEJYz+Z+anrinysPhR18
 keSgO1eqUWzXFKai7bKWaUSKCB1zJYTu/RyafOfqfffaOiHfk2U5UPJY7AqMH7KvL0V7AGKw7wJ
 pIN6E
X-Gm-Gg: ASbGncts7bbECnh/vI/M1N1wwq/0qapugOp5bu7Z7oBCQXbocpbSTTpaPi8YfE+g/Q7
 hAHqDDWshpphxBIuEYbLkkMOzto148Rf2ToOv5rmeLlSXRygiOVhGnBvbo708s7sauTq17CzWWu
 7rEiWEVO93fS7ws7EK28y4oFSzenzR2Mi1k6WjX64bnidgnvnRCjL3bJxxwSTqS6YmmxBJ4/ZLJ
 JRzBeG4JSPm9034oyNCITXakmE13J6PaFWzDdQXomUJpECSxrmM0cwXnGsoBM9y0CNtRaeIaa7n
 VFdrCY1Eta7xbHqe8LuJjZ1PIbmtJsIRDU4O6MdPJHoty1POg3e/8sCuDkMEhdnRpsUzwt5cCyu
 +TZDNvvPYzv8OVx1Ukb1nUm21lABi3xgPIjPajXzmMkIJkn5c0f52Lb8vH5t1LGT/8S2cS43ESa
 M=
X-Google-Smtp-Source: AGHT+IFRaZU9iFfEocvSfO8XSxYw2ouT1qdvPwHqCoIYnDmFJB6TU9Ga9WDZ6B7rL8stmvaSVEVEOQ==
X-Received: by 2002:a17:90b:1e0d:b0:313:1e60:584e with SMTP id
 98e67ed59e1d1-31c9f3fc0eamr5593504a91.9.1752696983103; 
 Wed, 16 Jul 2025 13:16:23 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b3bbe579b0esm14231805a12.22.2025.07.16.13.16.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 13:16:22 -0700 (PDT)
Date: Wed, 16 Jul 2025 10:47:36 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jie Liu <liujie5@linkdatatechnology.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v9 01/14] net/sxe: add base driver directory and doc
Message-ID: <20250716104736.16b27940@hermes.local>
In-Reply-To: <20250716082930.83026-1-liujie5@linkdatatechnology.com>
References: <20250715034152.7020-14-liujie5@linkdatatechnology.com>
 <20250716082930.83026-1-liujie5@linkdatatechnology.com>
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

On Wed, 16 Jul 2025 04:29:17 -0400
Jie Liu <liujie5@linkdatatechnology.com> wrote:

> Adding a minimum maintainable directory structure for the
> network driver and request maintenance of the sxe driver.
> 
> Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
> ---

Please a release note (in later revision) that will go for 25.11 release.
