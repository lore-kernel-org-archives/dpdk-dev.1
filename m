Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE70EC44507
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Jul 2026 09:23:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1344540A7F;
	Fri, 17 Jul 2026 11:23:03 +0200 (CEST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com
 [209.85.167.44]) by mails.dpdk.org (Postfix) with ESMTP id 7B8F240684
 for <dev@dpdk.org>; Fri, 17 Jul 2026 11:23:02 +0200 (CEST)
Received: by mail-lf1-f44.google.com with SMTP id
 2adb3069b0e04-5aec6360133so6063973e87.1
 for <dev@dpdk.org>; Fri, 17 Jul 2026 02:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784280182; x=1784884982; darn=dpdk.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=f+GRN9CN5SczJAoqL/hPa5Kyx1E/0LZHIAl0zAyx6Wc=;
 b=YN6RHY8pS+/ti4pbYmkIuyax0t1tXbz/egWhxlvGgK/NVreud54AkihDEa4sRjkrvx
 FgDEDA8QqRHeoyhE8vyMLBEZSrKl3HmPOSKNzpa/NqzfKLkMfnt2KeyxNj68zdxqxTx5
 ifWySYniBsuyRjUy+mGDxv8430dilwhLTmgJYn6m2QH3eVhUdohcgWZEUyBIA/tSw3tJ
 cyfL6K/serhMzGyDPAnhUGBkHxyqiBLTkwf6IgvuNpmVqsAZWtpJ5apQM8ubFRp/5BEy
 JBaHI1roeSgLb/Ja7xk0Q+40vh6A098Okt71NDZ7KVTVbPVk+WpCRtAyuCtYgA4awwfN
 junQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784280182; x=1784884982;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=f+GRN9CN5SczJAoqL/hPa5Kyx1E/0LZHIAl0zAyx6Wc=;
 b=c+ZTRRVMqbVINnVXkKEY79zQGi5bTkX9yLjcOHlf4lNLnQhNIV88Vlnpbw2Tb5et5+
 z0y/CP3KtQ3fuAHk6RKDGwy+rrowTj614AcrEJb9sfS2Jg4KU5v7rAatMzPokQAWn2nK
 hsxBz6ISEzArjzApmMFS4btxeSEUs8DcZntyV/iH+DPkk1ZRHoe2+Uji7Ne3+ReTR+t6
 tPOYI4C13af9YRuM3FO13tx5l0PFAn+eGIrcyi2us0iQELj7eYBK+mRysh24AxJNlOYG
 Gq+Ybu/DAx4PBghtbWxwdO89Kk4mBhRbbzI8xFWR+c0YElMnYRr97H3/eVocWtBcK9p3
 Rcnw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrPva3fYXItbA5ld+D/S+rM8rl431HgssouBgldymGHpUG4cK6A7L9JnSRU7VLt/fB4vUg=@dpdk.org
X-Gm-Message-State: AOJu0YyJTEXLdmqYiIMP7j9qiW12enejYkM2fN4uqqR168wEWJ6vMvT4
 aknlrj/99dJOmkEMWobIIO5JlzTrGvxHzB1Wz83wbK/p4edXBSV6IMeM
X-Gm-Gg: AfdE7clpgsVJtCnFz1OWVVbHj8wzQvB22dPZGCW7yP++Uk949EG1jmm2f5aYIf4/Bln
 fO/J8JlK3OJZfYjBVRGge8ZjyUbGqXDyWzfJXyfNpxE15CnUtPbs9557Zpel6TlokiaiNtPTNyL
 IKOoPe9DZsvsPBdWkpe7OGwXvrPEbmKdGPDHCxyFCs+sTBuJRlA/My2IfiKwr+xu6Q1Eh79qiCK
 zdU8tTQ65iriE0lt3iv08ePNWutVUaCx4khvi9if+8XStEyF3QEw3wjK7oBA0Y874fhjj25GWfw
 FhqFmuftyq8pj0l0DltNir+2QvE9iuiPr6ceI06G3JZ6BOBnRmCREnY9c9x+yoQJHtMWMNTVnVA
 JRnCLIHkFslWwi4EARudewHU5E8W5KJDF40q0VcnBdPJ9aJZHKOqPbTqYbW7V+827vLBwBhGXRc
 Rf0uGA/dl9Gx7cwPWsN8ivRKrtvPtnR6srbRhEimzpCGUXvXUFqq9aFA==
X-Received: by 2002:ac2:59c6:0:b0:5b0:1bef:2e9a with SMTP id
 2adb3069b0e04-5b28f9abf0cmr284448e87.33.1784280181498; 
 Fri, 17 Jul 2026 02:23:01 -0700 (PDT)
Received: from home-server ([31.204.104.167]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b291e25290sm197718e87.73.2026.07.17.02.23.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 02:23:01 -0700 (PDT)
Date: Fri, 17 Jul 2026 12:22:59 +0300
From: Alexey Simakov <bigalex934@gmail.com>
To: "Hyong Youb Kim (hyonkim)" <hyonkim@cisco.com>
Cc: "John Daley (johndale)" <johndale@cisco.com>,
 Neil Horman <nhorman@tuxdriver.com>, Sujith Sankar <ssujith@cisco.com>,
 David Marchand <david.marchand@redhat.com>,
 "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>
Subject: Re: [PATCH v2] net/enic: check notify set return value during init
Message-ID: <20260717092259.vfwlgwahsquw3z2x@home-server>
References: <20260715103105.39417-1-bigalex934@gmail.com>
 <IA3PR11MB8987D9D134E71F46596649AEBFC72@IA3PR11MB8987.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA3PR11MB8987D9D134E71F46596649AEBFC72@IA3PR11MB8987.namprd11.prod.outlook.com>
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

Sure, also dpdk ai review higlightet potential problems in memory
management

For example:

enic->cq = rte_zmalloc("enic_vnic_cq", sizeof(struct vnic_cq) *
			       enic->conf_cq_count, 8);
enic->intr = rte_zmalloc("enic_vnic_intr", sizeof(struct vnic_intr) *
			enic->conf_intr_count, 8);
enic->rq = rte_zmalloc("enic_vnic_rq", sizeof(struct vnic_rq) *
			enic->conf_rq_count, 8);
enic->wq = rte_zmalloc("enic_vnic_wq", sizeof(struct vnic_wq) *
			enic->conf_wq_count, 8);

if (enic->conf_cq_count > 0 && enic->cq == NULL) {
	dev_err(enic, "failed to allocate vnic_cq, aborting.\n");
	return -1;
}
if (enic->conf_intr_count > 0 && enic->intr == NULL) {
	dev_err(enic, "failed to allocate vnic_intr, aborting.\n");
	return -1;
}

Lets imagine that enic->cq is allocated successfully, after that
when we trying to allocate enic->intr we are failing, so in this
case we leaking in second if statement, this related to all error
handling paths in driver, since as far as I understand resource
free happening only in enic_dev_deinit(...) function.

So my question is it problem? If yes, should I address this issue
in scope of my patch or better to make it in another?
