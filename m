Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 146D0C83038
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Jul 2025 13:44:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 65A8A40658;
	Tue,  1 Jul 2025 15:44:49 +0200 (CEST)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com
 [209.85.222.182])
 by mails.dpdk.org (Postfix) with ESMTP id 862E040264
 for <dev@dpdk.org>; Tue,  1 Jul 2025 15:44:48 +0200 (CEST)
Received: by mail-qk1-f182.google.com with SMTP id
 af79cd13be357-7d3cc0017fdso351891285a.3
 for <dev@dpdk.org>; Tue, 01 Jul 2025 06:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1751377488;
 x=1751982288; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CDiGkVhwuM13LMLoivufkBOfhsm7Q6+67w48zDpUEIM=;
 b=O6BeWNAZoUc4FmIG/Z5u2yBkBijNS6DH3+sAbZ2a1vOu5MF7rYBodtx9LYjeOoAEON
 KfyxdmT9iJ1EopsHSaJ+mGpn+i2yRw8wZRkZs2Yzuz3n8DHeDGWJt6X1zYdrvSk/hFbL
 xEhcohve+Bq6kap0M43akzS5n+YUqGW78rceB6KA+Gg8dYnJGRPCa7xb1VfJ6h4dHWIe
 xBWyrI0jB1bQEk6T62g62pbFQNWR1XGS6m+UF0Eh8mE7Ut3YFnViqVg0FIDkfhOLFtTE
 f0oeTrl3MZ/kOImwzy25bkQIYAwRZu9LbVG6h9Qlc5DimGU7YI2Z59GSWrbVuQBLdOwx
 n2wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751377488; x=1751982288;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CDiGkVhwuM13LMLoivufkBOfhsm7Q6+67w48zDpUEIM=;
 b=hKMF8f/limx7aqt2qQEs7kFhiFIVUYV/HARkvj7+PiTFFTIUYk7kP33telXwfq+fsH
 S0HKxCPqqoi1VmiIh4xtOSlvD2MUqX5qaOJlaWrT+RnxsyVkDHkWedHkLpQl28J0ip6E
 +w76JuCSjUtk1FsugceBPsn+t9oInwYTD4QgqTLiBZc4ORuca/iiSHnKkipRVd3AcXtP
 xQrxnqDnBdDLHdLS0rlqQ7GV9YJDmZT6c+wMFtpmD1j3hoT65Jn0xvyghZoxEWVtFHAu
 XQ85Owt5HOqkDSEjRcHoRGqpNVV178uM1/ZEJthpBICxf9EZxc+j12viWhdR0Cznkk6J
 lJaQ==
X-Gm-Message-State: AOJu0Yz/S0zeAm/WaTaGfGwxbhfB246+ER9EdGp+J189Y/qEntcdxEPr
 eidOTZ/M997z8UlpfdGPVOo7b016RNrVrF6eC3AmSBWSg/6/uDq1xnIqm9CavSN8Bbw=
X-Gm-Gg: ASbGncs4W8IulF/BHWH/XUXhgzkqF/fI8+PpqDH/itpvumzxcHawKlYpm96S2qZdmh6
 FN+9Fcjh6TDGSD/XpZTH/rDNj/jMtbqj5ndR8EIadpsWczTrATI276KrWCzkTdRIC8Cw08MKTyD
 q6k7rlxxhfx0fsC7drfSuvQbF5mMyAY8fciO1EHOGXSR8enLT4AKusgZLkXmz4/aFWkST18NdYy
 B9KXJ1+JyYpN/F5d86QAmNfL6IB4ezj9OhsJTMBPbx/CkOWXUVeihRyskwSl9ZRSeRLJnZHiMxI
 oAI286HM+ARS83xvBccFZ9QcZx4siJ3GxKjMw/dhgg7+O8bnNQhSqPKRu+eX5yjbSDhOKTLF7v6
 OlGagkQ2PCgG2Jfrug+/n5TCdcwkV0HcmGMRd6ss=
X-Google-Smtp-Source: AGHT+IGsLlztFpvDnOSdJ60cWQfmVLm1Yj7p2U+w6l6mPOFsDwKBi6d8rZqcJgiTxwdKVBKKmELCPg==
X-Received: by 2002:ae9:f713:0:b0:7d3:90f2:c19f with SMTP id
 af79cd13be357-7d443994497mr1979417885a.31.1751377487650; 
 Tue, 01 Jul 2025 06:44:47 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d443204d75sm775471485a.72.2025.07.01.06.44.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 06:44:47 -0700 (PDT)
Date: Tue, 1 Jul 2025 06:44:44 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: vanshika.shukla@nxp.com
Cc: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>, Sachin Saxena
 <sachin.saxena@nxp.com>, Jun Yang <jun.yang@nxp.com>
Subject: Re: [v3 01/10] bus/dpaa: avoid using same structure and variable name
Message-ID: <20250701064444.48081c79@hermes.local>
In-Reply-To: <20250610091411.2500413-2-vanshika.shukla@nxp.com>
References: <20250602131526.3233959-1-vanshika.shukla@nxp.com>
 <20250610091411.2500413-1-vanshika.shukla@nxp.com>
 <20250610091411.2500413-2-vanshika.shukla@nxp.com>
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

On Tue, 10 Jun 2025 14:44:02 +0530
vanshika.shukla@nxp.com wrote:

> From: Hemant Agrawal <hemant.agrawal@nxp.com>
> 
> rte_dpaa_bus was being used as structure and variable name both.
> 
> Signed-off-by: Jun Yang <jun.yang@nxp.com>
> Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
> ---

NAK
Since rte_bus_pci has same type and name, there is no point in
changing the dpaa bus.
