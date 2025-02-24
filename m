Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776AEC021A4
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 15:35:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 985B041104;
	Mon, 24 Feb 2025 16:35:52 +0100 (CET)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mails.dpdk.org (Postfix) with ESMTP id 46DEE410D5
 for <dev@dpdk.org>; Mon, 24 Feb 2025 16:35:51 +0100 (CET)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-22101839807so98230655ad.3
 for <dev@dpdk.org>; Mon, 24 Feb 2025 07:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740411350;
 x=1741016150; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kz0buoGEWNxbPDSRnrzcM37ciZBTHJWRkTl+i4nd058=;
 b=l2YWjtn8SNrte71njsrMH4Nh4ukRJ8clyz0YY44oltbmwfyC7SNHbO3NLj4qNqcce5
 LgLdESDfbci8RiXCaEePQTM/8tmOsBbNQ4nc61oypyWr5nNSJ33NWWdEJ4zcAFpomhft
 MjhJd66WNqaGcEB0W86RJqCytbdsD/SucEzdS7OExbVXJ7FTkjHpMVYhEIfdgZ/Qabmk
 96QEg6d2M+zoAGX5QSqNJeFR455a4UzIoYL1OVuXPoGKIdEC3S4lIJB6RFDnXq7Azmxf
 whzZZ+/1GmTbo/CGUn8hv622LRJZIP5SU0uPaXWAbaRDJxV0VDlDzemiQRIEtyo1Crl1
 qxXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740411350; x=1741016150;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kz0buoGEWNxbPDSRnrzcM37ciZBTHJWRkTl+i4nd058=;
 b=uX3vw2n4W2xMu7nkrche7P6dDYN8H89V6N71WbveWYSuuIk14QVHOblbr1wouvW29s
 CnJ9KsW8JteRfKVHSB8m5I3tRJzhfOk3P0l3Uw63PrOSZhigXURIQQ9Mj4TmEPLwMjEx
 eK5MKqSKYPTXhTR7DGwySaPIEpD3RcMctzbxsblOhxT6K6zvY0BTjPboGXUZmmLeu1js
 Jf9bzeZ/jS7H4WfJsg+BWPYQBJohayImgL8l7nQ/XxFXqy8Ee6MldBMYYWYtn1cVpWu6
 FLrad/T6X7YddQ8aNlB5za/Kuqdju+v/pMloeS8lh2IFBOqmEZr9cks0D61eP2VMes3s
 7Gog==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKHNtaVTnf7ORMBW/hizhDRoDr5rnUuzx+c/4yovwKC60hV36JMYN/PSRnS7/SIQLlY1Q=@dpdk.org
X-Gm-Message-State: AOJu0Yx80d5FRYE/Oglh3Vl6w5izAuJEWN/mv5Ggr6Nt65iDWDsEMUCd
 VgFjLT0G1X2e+goqGFtHPD4yzF9U7D9vgQU/gPhFGydVgPp6Lve5ouwPx9TNMas=
X-Gm-Gg: ASbGnctw6RPPDz4F6fuu3gW1x/5MY/heQSaz8FAhl0yDbQ5O1Bz4MXB7hFTR39cPbzV
 xIOi6UatuQdCmwpyOrcfT7/+anK94j8ZsL4QyKB+xD9TGlN0uJb4xP5DgqUw5krJo7xqJBXg2xK
 9JIMwyk9ok/eNjYMIy5FPltaSZeewB6C5XJcHarmMTZRRupDtu1wrYjrdQ3XPx+W2PnbSUqda+Q
 lTzrdAkcerqonBtKrToR4081cHhZxefoxccup7cG4Ekt0/whFSx62ZVS5nS2JHT6qw5UXkUrmYc
 OIvBw3MdLLP+Dc5xjobTP70kHgbtLDb9dwSZsL7rqSKhHwsWzTUgALTPQaDah09XrHySwHlLFjO
 qAuU=
X-Google-Smtp-Source: AGHT+IGHU/FPztb7pMzYjaD3cpJYxf1jrPo+MRAYTx2Au17Nid4FBkquWbfqoAr6vs0n77BDNI8o8A==
X-Received: by 2002:a05:6a20:9148:b0:1ee:d06c:cde5 with SMTP id
 adf61e73a8af0-1eef3cd8553mr26990747637.22.1740411349842; 
 Mon, 24 Feb 2025 07:35:49 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-adf5ae6af3fsm11868238a12.53.2025.02.24.07.35.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 07:35:49 -0800 (PST)
Date: Mon, 24 Feb 2025 07:35:47 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: <shaibran@amazon.com>
Cc: <ferruh.yigit@amd.com>, <dev@dpdk.org>
Subject: Re: [PATCH 1/4] net/ena/base: upgrade ena-com to the latest version
Message-ID: <20250224073547.400117c5@hermes.local>
In-Reply-To: <20250224114011.1789-2-shaibran@amazon.com>
References: <20250224114011.1789-1-shaibran@amazon.com>
 <20250224114011.1789-2-shaibran@amazon.com>
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

On Mon, 24 Feb 2025 13:40:08 +0200
<shaibran@amazon.com> wrote:

> @@ -768,8 +768,6 @@ int ena_com_set_dev_mtu(struct ena_com_dev *ena_dev, u32 mtu);
>   *
>   * @return: 0 on Success and negative value otherwise.
>   */
> -int ena_com_get_offload_settings(struct ena_com_dev *ena_dev,
> -				 struct ena_admin_feature_offload_desc *offload);
>  

Don't you want to get rid of the comment as well?
