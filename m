Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36061CA0FED
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 Aug 2025 17:21:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E83584029E;
	Wed, 27 Aug 2025 19:21:38 +0200 (CEST)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42]) by mails.dpdk.org (Postfix) with ESMTP id 7C88D40292
 for <dev@dpdk.org>; Wed, 27 Aug 2025 19:21:37 +0200 (CEST)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-3cbe70a7923so44999f8f.2
 for <dev@dpdk.org>; Wed, 27 Aug 2025 10:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756315297;
 x=1756920097; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4LPJ6D/cIUlBy2w2Jg612nDcKW4KaRkW6QdbqBFsyp0=;
 b=ZJLNPgUvqVO2SOK//7FKeBKHja17GNJodvQ5FAEkTXFVthBWqyxUW5ZbmOfkXJ24UO
 DfHzTk4XhSqUCZeZr+uvSsspD4gZ4nOwsHOvKeFLm5hgZ8+lTBRN/B4S7pOLbDhuY8YX
 fGQFpXX6GKYOE20jkSDRrAmBtZRowvjSeXBB4C3p6RKy9l8ansa0DcwJs74O/F2xmjHE
 0JvmQTmEA5czcZW9KL1l6FFmxfbo5wRYrzcCPEW1atOu7Gj7cQ8m2wmqufJdHcsqOHEj
 nAKgSX6NNloN8LKRuSb3BeFTD1mD2bZNChy3oYp/WAkDjAmsMkR2o2TMBdGG/GIBv5Cv
 r/uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756315297; x=1756920097;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4LPJ6D/cIUlBy2w2Jg612nDcKW4KaRkW6QdbqBFsyp0=;
 b=TD/QNhD88LY8sOqBxURI4/0WB9HLENl5I69nWRrfBFa4weKLps2YisyT5cAUlowI4U
 fwujsU05UmZqdcctHx09/OZnmwDcc/zE1j80iocPnIOHUEoW9Tt3BujRzAo3zOYUB2Yi
 hWpgTfdCTJFApjYrFh1AwKqxZy/P6X3Ar77rR8lzIIPPEaU2jmhITI923ONgjIbzwlPL
 l4tSC7t93L1ASHN/JuB8kk48b1NGNMvFVc28rZpjBRGya+EL/EernFSFKRZp6sGvyNUe
 4sdis7+AqCg241Wh5erg17ZE1/FMn6KIMxyMzQMkgBccsU2DVkR61taQ41hx6+jIjJBY
 Ii0w==
X-Gm-Message-State: AOJu0Yz5V5Ai/qtVd5y4PIcrgegbxQGsbC5CptKjs2ZVgrKW0aDBGIy6
 uQU11s1fJcrZlxUL9ze7WFwbZH/nra0C1emlvqKKc/dp5Hm0ynABTqpRq+WKPTa0Y6bul7QGC5a
 q5eFK
X-Gm-Gg: ASbGncu20/q1zYGD7LQaZLOEIlSUSJUkYEDdzZn4u30ABHIg6J2BwoytV2h+VwE6EBf
 YOhaIHzSMwZ9Ad74kf6rskN4iQjAzjl0dJFfQfsQZYG2kq+BGUjFvHzG/fzCVFjHIp6FsK5DfXw
 +ArK733ZgDJhKmWz9y2F6RLJATfPvjSPnYh8NOBTZmqJw83Hs+hz0C5CSg1OoWUbGG1QYebd4M2
 JA6j+t4JzB6sE3pY1fRGEmikS/Hw6466b87eLlBQj3UZ68t0jS5CLc9a2rHrQETp8I1h1qq2i8p
 7RoEmz69Z9ymn8YNbdzcq06XC40E3hjc/Be2dioEh04XcKjFhfWAJZmXI5n+4F1sPvxDWvcZcud
 9yUaD+JoO0U1C1I3tWcVKkMWxC5F32fwQo6LhfKjvgby1vwFz85qP1wuoqa1tjzngDBoettE5Ms
 IDUWjVf067uw==
X-Google-Smtp-Source: AGHT+IGU1tSQqBWb1B/phlkzIokZXq4/XuJtALX+xTQ7LyK3/DqdWUaSgF+uhsN1Kg9mFRjd0REZRg==
X-Received: by 2002:a05:6000:200e:b0:3c8:5b40:dea2 with SMTP id
 ffacd0b85a97d-3c85b40e7f4mr10838128f8f.44.1756315296871; 
 Wed, 27 Aug 2025 10:21:36 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cbf1f5fc1bsm6297667f8f.54.2025.08.27.10.21.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 10:21:36 -0700 (PDT)
Date: Wed, 27 Aug 2025 10:21:32 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Schneide <schneide@qti.qualcomm.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, Reshma Pattan
 <reshma.pattan@intel.com>, Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>
Subject: Re: [PATCH v1] pcapng: allow any protocol link type for the
 interface block
Message-ID: <20250827102000.2accd146@hermes.local>
In-Reply-To: <20250827153852.1066521-1-schneide@qti.qualcomm.com>
References: <20250827153852.1066521-1-schneide@qti.qualcomm.com>
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

On Wed, 27 Aug 2025 09:38:52 -0600
Schneide <schneide@qti.qualcomm.com> wrote:

> diff --git a/lib/pcapng/rte_pcapng.h b/lib/pcapng/rte_pcapng.h
> index 48f2b57564..1b3f9b9464 100644
> --- a/lib/pcapng/rte_pcapng.h
> +++ b/lib/pcapng/rte_pcapng.h
> @@ -28,6 +28,9 @@
>  extern "C" {
>  #endif
>  
> +/* default link type for ethernet traffic */
> +#define DLT_EN10MB 1
> +
>  

It would be good idea to guard this definition with #ifdef so
that if user includes pcap.h first, there is not conflict.

#ifndef DLT_EN10MB
#define DLT_EN10MB	1	/* Ethernet (10Mb) */
#endif
