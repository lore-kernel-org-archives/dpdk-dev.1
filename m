Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4062D10F5D
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Nov 2025 15:02:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 59BEF406B4;
	Wed, 26 Nov 2025 16:02:28 +0100 (CET)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com
 [209.85.160.178])
 by mails.dpdk.org (Postfix) with ESMTP id 44CF3402D1
 for <dev@dpdk.org>; Wed, 26 Nov 2025 16:02:26 +0100 (CET)
Received: by mail-qt1-f178.google.com with SMTP id
 d75a77b69052e-4eda26a04bfso76821291cf.2
 for <dev@dpdk.org>; Wed, 26 Nov 2025 07:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764169345;
 x=1764774145; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iC7OQl5u4XT9w8lInRhDL2VkSX8npDA4puo1vgbwbeM=;
 b=yK4A07v5eiF6U9X2fqY5UaBfYgT9Nt2QHedm+0ECDjCDbDbpOGY1kd3nyZu67ZFJkj
 DPGLREliTsrMspmg9eoeh0i85EA/s9GbgfxvkvxkmHm/nF+SMQkQAf++XeGgrYxV45Vp
 5Be6e6HqYVtvJ4Yqi2TQMy6Qz2GCp+hIU+18iiRZXJWvE7DAIla69VAk56SQ3G0DnTUa
 jAPX1id5t9b0iaR/K6N8AAOsdWSs/VtrmJKWLIJQEBB/Dq0P46DFcidMFw8aX/qMPbC7
 7CVfmgdfH9dUtEAFC/7CbNJYxYtutIqt7A5qNRsGTMgmfx7s4PfAUV6JIyLxdtZVOZmX
 w/PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764169345; x=1764774145;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iC7OQl5u4XT9w8lInRhDL2VkSX8npDA4puo1vgbwbeM=;
 b=Gy9jPtTlchoNHhAdzzWkPqml3MuXXF3w3S/UmPBpA4W1PRvfDJnoCfThKBJsPp2dsj
 14R5J5g9cDd2ZwDFv94EBHR/eb8uYbacaQDPORnqCsxLYPVC01yrXSjZ+zfmQ6Fiw98z
 r0HDjtjV6FkW08Wh0QiUQoO4qi5mlQJlB94Ul8dCo39y80vYfE8A9eeYm/KnT++XeHqZ
 TyW+wNzcyYwmtFZwK7NeL//+uGIcVAlMsJaPszJ5ICLk4qRfUs3j9NHMbbO2B5sIcr9U
 bXzcy1XzSMwUiOs1JUbMiSqaYr4MrQH9Zd8I/bv5wY16jV1Wv7z4An+YLDNvrNR9OnCU
 atew==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5apoucCdh8Lq6LElMZYGv0Y8qQPL6vXhUwvqZPYQOJI6rQ9zfU4JauGOVsYl618YZcS8=@dpdk.org
X-Gm-Message-State: AOJu0YwwJHmls/kqgraOflXjX3eqBydzsH+eRlm8bgPanrIOgXI8Sy5m
 1OQ/uOQommvHFbrwLXY+h386HL3mifgk9i4fDJlKWzZp0qE6ybF6jjuuyut3snY8LJk=
X-Gm-Gg: ASbGncsDQ9MPXr5pjJZXg5EthEvW1V6AuQ1NzPCIE93Eui625EDi2Cj5BhaO1hqUYam
 e0vOu+LmB80Ls0VJWQwyATO7yPk4TsDmfHiQGjrgSimGnHfUNXCYzhcXUq8fbdedJDJdMWb2E5Z
 MUuk71tp/78n5eeWSxuUe6ftVSPU8LkmC3uS4f1TpinhH6f7m07L0s40mHfoZlMV+/wSWdjEBzI
 l7IN6+9bSG7DVQI5c3AV+Il2A4EWeoeSPjbJqb6gz9kKsxKkC0Wkz2HTo27KKV6ioZiafVGP7mZ
 R+y80Q5cDjhYNjLgogf8Kif+c6/oi79JFHsejm8rL7UeD80pL87lLPag/r6qOmk33CZYpmg2Ftk
 VeBdh/yP+3xxXLYDx/SvWRvr9O0DvRDg+2HWsDaMTkfYmDIKiDcRgKmcvhmGAIXD4VESkcWHv78
 I9MkcCl29Jy7Y2UTPS1sE1nvHVn+zmtPNswswGTb97PuuKuNU2R1Zo
X-Google-Smtp-Source: AGHT+IF7yoTNIzmftEPh9onnvOUIdK1huFds9quAGQesaDWE8HMX0b8KSSp9MQc06XJ4CLHV3WXEKQ==
X-Received: by 2002:a05:622a:304:b0:4ee:24e8:c9b6 with SMTP id
 d75a77b69052e-4ee58935c51mr267710431cf.59.1764169343716; 
 Wed, 26 Nov 2025 07:02:23 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4ee48d538f6sm127520761cf.10.2025.11.26.07.02.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Nov 2025 07:02:23 -0800 (PST)
Date: Wed, 26 Nov 2025 07:02:17 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: a.schollmeyer@syseleven.de
Cc: Aman Singh <aman.deep.singh@intel.com>, dev@dpdk.org
Subject: Re: [PATCH v2] app/testpmd: warn on shared rxq switch mismatch
Message-ID: <20251126070217.2b127bac@phoenix.local>
In-Reply-To: <20251126104009.472852-1-a.schollmeyer@syseleven.de>
References: <20251125102207.428661-1-a.schollmeyer@syseleven.de>
 <20251126104009.472852-1-a.schollmeyer@syseleven.de>
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

On Wed, 26 Nov 2025 11:40:09 +0100
a.schollmeyer@syseleven.de wrote:

> +				if (mismatch) {
> +					fprintf(stderr, "Bad shared rxq config: "
> +						"%s mismatch in share group/qid %u/%u: "

It is better to not split formats across lines.
Can you shorten it, and put on oneline.
Despite what checkpatch may say, you can make that a longish line like 200 characters.
Also, maybe break from the loop on first mismatch? and return an error?
Then message can be outside the loop.
