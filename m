Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F130FA3728
	for <dpdk-dev@archiver.kernel.org>; Fri,  2 Jan 2026 17:10:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 761A540267;
	Fri,  2 Jan 2026 18:10:48 +0100 (CET)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53]) by mails.dpdk.org (Postfix) with ESMTP id 4724F40262
 for <dev@dpdk.org>; Fri,  2 Jan 2026 18:10:46 +0100 (CET)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4779cc419b2so96668645e9.3
 for <dev@dpdk.org>; Fri, 02 Jan 2026 09:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767373846;
 x=1767978646; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4obIiEyQwjZzK5jAFpshsyJVBDS3B6F/0YnokEjfB2c=;
 b=j4Dv7g7mpYmDATBrdyY9dt9FzH9+WWCYFT7XLIN01ZiJAPfEQI3Ub+3Jfpq/LJUGAr
 y2LLU8Pw21RsPLI94znMniAaG6rK8c4FUX19OaFbGfUeliW0BB7Z0Ib1lMfLe8oP6yK6
 sLhszFf88oq2ektxaG6RN+Y1p3xQ4EYeuQTyT4TiBqwb/eRHg7s+m9EG3NKI/JungFka
 uQf6qDX9/yMx19wgZtchKbsxtvUDzZl647q9WHkuU0bvFzzxPY6297SnQxnLBt42AvVr
 SQB1zNg+5pnoTMu/ls2CnmJYdD+9E5A2JtaBEnHJFQDBqKEtPs2FkeJWk6SXZGx85yK+
 cNHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767373846; x=1767978646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4obIiEyQwjZzK5jAFpshsyJVBDS3B6F/0YnokEjfB2c=;
 b=KFFeJUGv3tBjaw88et/eRC1jtOmd2kK6oZ6kqRXCSbb1JaTGbmQRgERT7+/a0ldg6s
 12L4VCqZPLoJ/oXmDYBMmfnPEutJ8iSx9t+YD3usracPSn79t5kioBahWwynaSIQosmV
 9R20zjRWxls4SKguvrlRj7ZI/DsCRTSQQC6J0LU2jLyImPvUIobEFnWFohijG8smZoxn
 JjEuhHGOuctKRiTkFirbtvi+ovx9+dKLn49wLTNK7URLpalSF2L5JRxsX+oN2nq86PH+
 VWAagr9Bq20RZ33uIquvWPz+PtEvzBky4FPFpu9vWbQL8COtZzRzwjR/JuMQgR/HLxee
 t4SA==
X-Gm-Message-State: AOJu0YwNiBZvJs6HT5TESTw9kf3MBMnkXDn25A4vxfzfML+fDurUrvoT
 lf1beBumLTNB2NgRYCCh6iR8FEngIObMyqorfqr1YfRSlWnvmOHhcvXebZI1HMSCsJg=
X-Gm-Gg: AY/fxX7vgqEqHFeF+3b/oOkI+wSxHUhyaQN/5Q5XxtkE1pf0YNeqgxORR+C2/kuiekC
 3bz3Mdrj9Qks5j6rVWSUftC4HpDQAkZ2JDWwzA55PCzXM0/GH7AbnefIV/gh1Kkiu5LBq7WT+Pr
 c5Stds/F02ks84vmQ+drsmFk+6LPf9SBoO4D9aniZSNAPx9+L1IwL3JlGQg5F8zsCMpnPuW6qZ2
 g27sVPEvuTztZDbXgvBBqTSqupUT22/IUcU4Tp4fcMjgNyO/k/RB5i2TgqDlMjKM2cA+mXQn3oG
 QNUunO2ZHVmM1TIrsBugz81PfFakV+b3hK1Iuo6Nidk15bf3rqgsnMwpn6lTFBuSHpplexfvDn2
 q/kpPf6LnW7fD2RtULMvIt4Qcg84yAnL+kD4dJIbW/NBKcBkVuK73mwOO3mZsIAqXZYXtUt5SaC
 ZiMMvaiCV9FhkNoVJtNBk88w1oa6icS9A0bPSz02QLmBn5rf6WKKFC
X-Google-Smtp-Source: AGHT+IF/DUoD9U2I4gp5eaIxhuj+l6Ky5q/+mXyW6huUiMi6kOAHDZ/xUcHth/shzLW3Aa1mmVXciQ==
X-Received: by 2002:a05:600c:4e90:b0:45d:f81d:eae7 with SMTP id
 5b1f17b1804b1-47d19593896mr514936565e9.28.1767373845641; 
 Fri, 02 Jan 2026 09:10:45 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43277b0efefsm52575386f8f.25.2026.01.02.09.10.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jan 2026 09:10:45 -0800 (PST)
Date: Fri, 2 Jan 2026 09:10:40 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Marat Khalili <marat.khalili@huawei.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH v10 2/9] test: add new function to get current
 file-prefix arg
Message-ID: <20260102091040.696b3d43@phoenix.local>
In-Reply-To: <c49bc9ab7aea4f7b871a77d1ef79ddea@huawei.com>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20251229220053.21981-1-stephen@networkplumber.org>
 <20251229220053.21981-3-stephen@networkplumber.org>
 <c49bc9ab7aea4f7b871a77d1ef79ddea@huawei.com>
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

On Fri, 2 Jan 2026 12:50:14 +0000
Marat Khalili <marat.khalili@huawei.com> wrote:

> > +/* Return a --file-prefix=XXXX argument or NULL */
> > +static inline const char *
> > +file_prefix_arg(void)
> > +{
> > +	static char prefix[NAME_MAX + sizeof("--file-prefix=")];
> > +	char tmp[NAME_MAX];  
> 
> Can current prefix change? Can we verify that it is filled already and return immediately?

file prefix comes from command line and does not change.
Given that it is used to setup memory and ipc it really can't change at runtime.
