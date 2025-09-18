Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6DEECAC5A0
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Sep 2025 16:39:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8993340676;
	Thu, 18 Sep 2025 18:39:11 +0200 (CEST)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com
 [209.85.222.181])
 by mails.dpdk.org (Postfix) with ESMTP id 60FB34067E
 for <dev@dpdk.org>; Thu, 18 Sep 2025 18:39:09 +0200 (CEST)
Received: by mail-qk1-f181.google.com with SMTP id
 af79cd13be357-82946485d12so106789885a.2
 for <dev@dpdk.org>; Thu, 18 Sep 2025 09:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758213549;
 x=1758818349; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GtqTCj98OF+b/uQjWW+jbQyaf8ZLjfUdEKDjs1gBLao=;
 b=D2FfqWW8KcBYiofjHlEvzjHlzUQz+IWbe3eclMjvzVw+GwAgirEbb4DQ/cALH3olvP
 LHPwP6HcjdjvuoV0eDnRMTFqp14wqr5jbgCMn6QY9YgSuRHiyn9HKmQzbcZXpu61Fbaq
 Tq8LjAllkZSXDbxJmqy2TzImDwquAHG1bEzJh8rx7w+SDg5RD2g/F9XVvqhukkmxUYWj
 HCjBaeWV0I+a2GxGT6zSsv3nq8T5ScLRcSar+kfykXvLBkulfGoG/75raOpMXaxN6Edh
 M/Q4OQelRWKxxUgA6bG8uGliDZVhmmwCsjc48U3hdb33i9twUrwL5EsmkGZbpKaZ4/wr
 mhag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758213549; x=1758818349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GtqTCj98OF+b/uQjWW+jbQyaf8ZLjfUdEKDjs1gBLao=;
 b=VuNOZeLu0OveR6ITQUA76AKaTU99TLF7i10DmaOEcs1jP6QnPncz8md03f5VrrcmJy
 FClLY6xyqnRgyP1w4Q5jynu3l3XY50RoRST05DA0YJBFZqNgqLltN/Qpz699rzNc3BW7
 zZJDH+pn0KrdfML1GmjOy6N+n/uzGI181BX1aQ0T1QVCTAEIYLkuav29CseurszZ3AJJ
 c1Zg49O1lzJFdUd/mfJrFIK2A+J410iaYpk/efPBOxvcv5PNAWac0zSwxBUB5lwmbIz8
 6hyYk9opCyMiJwgUaMCf0tXX/q+IgxAjbDafj/xsau/EbbYjBuFynxisfYNV1rvjIgDg
 SS1g==
X-Gm-Message-State: AOJu0Yxp2+l+PAU7BHg2dGITA3D7Xybi/0zutDff64CCGkWMJD12lGN2
 zRQlfccUREx0UaYYlqmnMqMpIN2N6BDwTE7We9qTWOieKHc1FoTXlw3kzjVVuW6Oz+U=
X-Gm-Gg: ASbGncsOxnlDyI4JCdkufQT9qbYxAnw27JXWR24AhjA7w3ZdW0Fof1p1kA/k2a80Vi4
 pPDLLMUn8GGBTqMepx/CqTdPo0EM+iAIO+dzfF9+0Yt6/HUQqjq7PXyqrvxacgr1Ng+tAVWKndQ
 WmMy2h1WW4gwi6Zv8Bl4+S0EcK/Dq+m5fRZZsBMyxi2Z4sBySVM+ekhkPqswepMM4Q5w0Zjujgi
 0f1qcJuGkYZhfk8a9iQ7GqhSa8UFhgqOgxugJO7QGtNGLC2/qKkaC1ksZFXHSAM5FjeEiWVTBCe
 mRNbR6Hf4qsEwhrSJ6osbKRVXJXyW/0dtsey+DM8hIuj5L+0SoP7mqS6IJ5jbnMvZUsLr3ulty5
 02bx5HMv1QoA65dUIwguClCQkeZEFsK5cvYo5i9utiLjJ+VNAgfRpkHxqE9ESd5smSdomeXwUvq
 Biif3mQlwvUzQzbXnkNxCd6L6vWjjK
X-Google-Smtp-Source: AGHT+IEEAGThvM+z9yLdOE97N8YhortJYeQpNC0gKZGH5cY5p9+698hOjhJpZGDeBPko6Jdqc/Lhug==
X-Received: by 2002:a05:620a:658e:b0:81a:9d8c:7b26 with SMTP id
 af79cd13be357-83ba589b363mr24067085a.34.1758213548480; 
 Thu, 18 Sep 2025 09:39:08 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-7934636f947sm15099276d6.16.2025.09.18.09.39.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Sep 2025 09:39:08 -0700 (PDT)
Date: Thu, 18 Sep 2025 09:30:57 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dimon Zhao <dimon.zhao@nebula-matrix.com>
Cc: dev@dpdk.org, Kyo Liu <kyo.liu@nebula-matrix.com>, Leon Yu
 <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: Re: [PATCH v9 04/17] net/nbl: add Channel layer definitions and
 implementation
Message-ID: <20250918093057.1333d86b@hermes.local>
In-Reply-To: <20250917080843.646050-5-dimon.zhao@nebula-matrix.com>
References: <20250627014022.4019625-1-dimon.zhao@nebula-matrix.com>
 <20250917080843.646050-1-dimon.zhao@nebula-matrix.com>
 <20250917080843.646050-5-dimon.zhao@nebula-matrix.com>
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

On Wed, 17 Sep 2025 01:08:30 -0700
Dimon Zhao <dimon.zhao@nebula-matrix.com> wrote:

> +	if (wait_head->ack_err >= 0 && (data_len > 3 * sizeof(uint32_t))) {
> +		if (data_len - 3 * sizeof(uint32_t) != wait_head->ack_data_len)
> +			NBL_LOG(ERR, "payload_len do not match ack_len!,"
> +				" srcid:%u, msgtype:%u, msgid:%u, ack_msgid %u,"
> +				" data_len:%u, ack_data_len:%u",
> +				srcid, ack_msgtype, msgid,
> +				ack_msgid, data_len, wait_head->ack_data_len);

The grammar is incorrect, and prefer to avoid splitting error messages
across multiple source lines because that makes it harder to look for the
error in the driver source.

The bigger issue is what does the error mean? Driver bug?

> +		copy_len = RTE_MIN((u32)wait_head->ack_data_len,
> +				   (u32)data_len - 3 * sizeof(uint32_t));

Why the cast to u32 when variables are already uint32_t

> +		memcpy(wait_head->ack_data, payload + 3, copy_len);
> +	}
