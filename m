Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24976C83F27
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Jul 2025 03:57:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5B1F24064E;
	Tue, 22 Jul 2025 05:57:01 +0200 (CEST)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46]) by mails.dpdk.org (Postfix) with ESMTP id 2E6A9402CA
 for <dev@dpdk.org>; Tue, 22 Jul 2025 05:57:00 +0200 (CEST)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-31393526d0dso3490699a91.0
 for <dev@dpdk.org>; Mon, 21 Jul 2025 20:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753156619;
 x=1753761419; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HGcwHRpjK20yD6VUnrBnvIeRa7AZvsPGWIF8WUOFl2Y=;
 b=QaH2QV4pk4nyFXv2EaGmgBh9O3Pzdx1jxn2km0Q+c79AQ+Tz94BpWWqlqlz+sYZdpO
 yNoLgiFE+gQIudj+HLu+5W15gXkZ4PHKDhlUao+xxGC8pPISCuTJNMfI2ljDPk6E8h42
 KNgKvcV2dpXYIcRI+ieekCiqcjt9WUHc/bvKssMhwLSZKbaNbS1LqA5TFeazjwXQ205o
 YuyZceTedC5xCHmqz9ITPKsQRo18aHzPS7MNLVBYbRpKV3uVdL6g6thnIDQrXS6s/wXf
 qWcZ6lI3SZ7S7ylImi05SP9JOl0QPZjFlO3SnnsbQxW4XoaJc0vHF3aYlH/+6jOlDb34
 4oIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753156619; x=1753761419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HGcwHRpjK20yD6VUnrBnvIeRa7AZvsPGWIF8WUOFl2Y=;
 b=I6+hrfNWPBCghpNMFCR/wldDTPC0xiR57UeKWqBDGFQkHqeCqg1b8r0sUKnQJAumkw
 EKm4vF1HAfqSuE3l8v6DViRDzgvos2lPeKArPltNbxXt3Hmckzg9HPzDa/SD6iBL/nKS
 iXRNLYe3mv2VxS08FHae9aJRj0uK7D7TObh/nSzGqZv61LV8qCfZ+bEVNmwl1rDsqCXg
 th1DTAtYN1RILhZ7uXB9zvsLH4J2Mq0FhXxyAWXLp3B1OxDxVBFkh3VWOlkJsBQyjMNA
 UzmRgrlea9IE5DXe/sEibf2IGU25FKfudLBra3JkpHam85ByBjFx4JWktpce8Vx8CLU2
 XLGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/kLEdIBoKvlldxTm3qpNoXmn/73qNOLmflZsOn4Wl1iZeJUsoECoVDOVCbX+o9DswHWA=@dpdk.org
X-Gm-Message-State: AOJu0YyFmlEalm4VPuFEJYchtITYzxQDq2dthFvrK9JWxcsQlSYTERwg
 BFwuVt1ps9h1ccJfIvi1ICzK6DucPInPltlmB77OlVd2jX8n9/Pot1DbPXnp8cMEIZA=
X-Gm-Gg: ASbGncuuzqH3qr/402y7dUELpp9GI4CD21TkCdHcfwzZWsjS9nf36mBjF2JysnzMxsW
 cD+GmKzDXlhZaf/D87o3SrDiwQlS8yULEEmdO74dhuix4+dvcHxTTSnJZmYkfM4BqeUw4QJi7MD
 cvPXHSTwKcJP0iUXk3CYgFDgo1nO4hGflp3/Q83+xnbQDPnBEHTVUR0GWAfnYzkAlt9XyI75tZK
 /th8W0mmSOzfLSudhpC0d+YdbQ4rA+vHemJKFcOQDnMpsQjsBrMSfcVo/zI/Z42/9BTiqzdFaBt
 xZfbmqmS0RoSjCjct/HUQS29frd0a/AvYERzzyagLb4TdxXEeM5XW+vIMrgZjNNLLRZFMgO/PsA
 BCbwkZ/AvA5S/W7oW6z47oZE/DcT9a/JdPvnmAj/lzu+KRCHgUaP7TV+gWag90bK6mQprZ6yOtj
 8=
X-Google-Smtp-Source: AGHT+IFbOwOMx1FOvjr6cJRIW9jYZU6QWn/l1BWCNW5vX/c2R0S0gRojzVzBbd5cK+b4dZr5JPTdOA==
X-Received: by 2002:a17:90b:5281:b0:313:28e7:af14 with SMTP id
 98e67ed59e1d1-31cc25c8270mr19273610a91.19.1753156619221; 
 Mon, 21 Jul 2025 20:56:59 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b3f2fe8ea7bsm6119132a12.21.2025.07.21.20.56.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 20:56:59 -0700 (PDT)
Date: Mon, 21 Jul 2025 20:56:57 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>
Cc: Aman Singh <aman.deep.singh@intel.com>, <dev@dpdk.org>, Viacheslav
 Ovsiienko <viacheslavo@nvidia.com>
Subject: Re: [PATCH] app/testpmd: report minimum and maximum MTU
Message-ID: <20250721205657.4956306d@hermes.local>
In-Reply-To: <20250716102847.1118815-1-dsosnowski@nvidia.com>
References: <20250716102847.1118815-1-dsosnowski@nvidia.com>
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

On Wed, 16 Jul 2025 12:28:46 +0200
Dariusz Sosnowski <dsosnowski@nvidia.com> wrote:

> Add reporting of minimum and maximum allowed MTU on a given port
> to "show port info <id>" command.
> 
> Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> Acked-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
> ---

Queued to next-net for 25.11
