Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 390E0CAC59A
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Sep 2025 10:16:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A5C2B40655;
	Fri, 19 Sep 2025 12:16:09 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 5FBD9402CE
 for <dev@dpdk.org>; Fri, 19 Sep 2025 12:16:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758276967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2J1O4Vs/VZFqLqzMB8WsDpKQ8ZfkUzZ5lPfLr//yyik=;
 b=fzHRYpq5l0ZnUvmKXpjBMggXOlsw0CZkoe5MK+DupqJi3BFRw2hwfz1quD2jtN9FNSZN6g
 UIzjvMkpN3vy7I12ms10tnZU7EdKJoDaTQ0dMO0gI3t/I1nrFc3KJMgeBFsjrqpED38IWS
 n3eDjOH6PC5guRQKdBRQwYwBRGhj28E=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-n_6z-4TMMFWMW_TTYI3SNQ-1; Fri, 19 Sep 2025 06:16:06 -0400
X-MC-Unique: n_6z-4TMMFWMW_TTYI3SNQ-1
X-Mimecast-MFC-AGG-ID: n_6z-4TMMFWMW_TTYI3SNQ_1758276965
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-57875e2885eso1409229e87.2
 for <dev@dpdk.org>; Fri, 19 Sep 2025 03:16:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758276965; x=1758881765;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2J1O4Vs/VZFqLqzMB8WsDpKQ8ZfkUzZ5lPfLr//yyik=;
 b=kHMmTklUF/nr/ydWxy8Ng0JfdbJvosVEjW9MvukiOMTzQcI6bqrH89yb+6VtwDDBHO
 jZrEZiDcFTmXQqZFUJTU67AUTkjYQnpLu0JEgwavM3rJbCo98vF64U+6JKK1E2KDWb1U
 GLTZ7ROvfEizRPZ0Jc4CG5vf1N7fHE+ZyZ4QDziuMkS0Y4Zh5ZAUADfewiPfuE7nqfgy
 5s4RJj0FNqHR99c6GKh2J2es/k88Gx7VvZR2Q/pM9wnsUGjj0RRXlXUsdiivikpxJ6Zp
 cXjel1YWCJyg1zg9VMGyodkJ2oTahIeYjvxZH0CUrYpDOppzEpWIxtV8YNtk6pabMqTt
 njqw==
X-Gm-Message-State: AOJu0Yy+5aYFfs28h3UT65AuxD6g7LVArQrs68jub5EZLH9cDJAJPOOX
 LMct5iKQJt6L5BQE1SzY7NZUgLgbGNODWISS5nabz8veaneLVam3Vka5MN5+DfH0iWtX6dLgIK5
 XWHqCZXY3vZQo3FCYiwS05n1uTKDeRtNRhSaW4KQTvKGhzKdf6TZRShzDYX/dhxuOEBuPaqMBfe
 fVc2JgUDryRBAIbIMXB6I=
X-Gm-Gg: ASbGncuR6Ma4YFN6deTaUI/1ELbLn6cgjznfVv1dc6nYMj+2unH+ERcOFAiuOKEDUK5
 7c4rWAslRhP/oSWC7ks9kNZhaUbBN2F/NoFOPZKO4mrTEQOXl+/qQz/HP3JC+wv1b6GBweVlbYL
 i1pmjWhy9gWQkls2r2fqdy3IY=
X-Received: by 2002:ac2:4bcb:0:b0:55f:5685:b5e9 with SMTP id
 2adb3069b0e04-579dfbd43damr1196099e87.8.1758276964922; 
 Fri, 19 Sep 2025 03:16:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+bdVCv1yqE0cVXVKsIxneUMeL4z+We3vqWNuYBHl/LbYNbZAEkgq8oVds8infj5rSglLHxY7zwHNDc2QbwfA=
X-Received: by 2002:ac2:4bcb:0:b0:55f:5685:b5e9 with SMTP id
 2adb3069b0e04-579dfbd43damr1196080e87.8.1758276964505; Fri, 19 Sep 2025
 03:16:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240829085724.270041-1-konrad.sztyber@intel.com>
 <20241011111533.20746-1-konrad.sztyber@intel.com>
In-Reply-To: <20241011111533.20746-1-konrad.sztyber@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 19 Sep 2025 12:15:53 +0200
X-Gm-Features: AS18NWCfLVdSog8oIcOuI1DAsiy07ZbZQOz4aGpt3hspzihV9jhBRj6JgwHPm9o
Message-ID: <CAJFAV8wiAPumykSavocAZe6eKYFPobTOCcHoDe3yqnf_oeoFmA@mail.gmail.com>
Subject: Re: [PATCH v3] bus/pci: don't open uio device in secondary process
To: Konrad Sztyber <konrad.sztyber@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>, 
 Chenbo Xia <chenbox@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>
Cc: dev@dpdk.org, Chaoyong He <chaoyong.he@corigine.com>, 
 Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org, 
 Long Wu <long.wu@corigine.com>, Zerun Fu <zerun.fu@corigine.com>, 
 Thomas Monjalon <thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9eoYjuseE8WRjzKZ3aAiyIb4nJlqk-JAn4gH9M6ZbdI_1758276965
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Fri, 11 Oct 2024 at 13:17, Konrad Sztyber <konrad.sztyber@intel.com> wrote:
>
> The uio_pci_generic driver clears the bus master bit when the device
> file is closed. So, when the secondary process terminates after probing
> a device, that device becomes unusable in the primary process.
>
> To avoid that, the device file is now opened only in the primary process
> and the secondary gets it over UNIX domain socket via SCM_RIGHTS.
>
> Fixes: 847d78fb9530 ("bus/pci: fix FD in secondary process")
> Cc: stable@dpdk.org
>
> Signed-off-by: Konrad Sztyber <konrad.sztyber@intel.com>

Sorry I let this patch slip out of my radar.
I see nothing wrong in this v3, but could you rebase and resend it so
it goes through our CI?

Anatoly, Chenbo, Nipun, please have a look.
Thanks.


-- 
David Marchand

