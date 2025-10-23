Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FCD5CCD1BE
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 16:09:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 81CB340276;
	Thu, 23 Oct 2025 18:09:16 +0200 (CEST)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by mails.dpdk.org (Postfix) with ESMTP id D37FE40151
 for <dev@dpdk.org>; Thu, 23 Oct 2025 18:09:14 +0200 (CEST)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-b6cee846998so659144a12.1
 for <dev@dpdk.org>; Thu, 23 Oct 2025 09:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761235754;
 x=1761840554; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IvyTBKiFgNnVZxy8+zucv8mMfk44ZwQ78jUmAUBSv4Y=;
 b=X3XHr9Vdcog4UUXmpGZyviF71Tt/w6chLY1TXw7I5/wTgRrEWq/zrPAHAClRdGMtYY
 weOPvkfguYAgCpOsl8T6jX9ZHLsq/oOtMwlE76z5yiiD0Zn/MliVO9u0dAJjIYE+od4Q
 149VHUs2OurF9fadT3Ctbt5eict0EIrUZu7QS4bzSv00C0ombM0sfD9aY6BEEK4NrHEv
 ZTyHmtaAbI3Gp4K2gEJilpBBBVwObJWppslk0vsDVHIGzHith98GkaWNCGOh9ADW7pfP
 1FlfbnvqvCUeOnMiJTkLqA98Csfy30vxz5IQ4Hnrmm8aGXA4Y37INN434EYV/pOMtMzL
 i0rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761235754; x=1761840554;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IvyTBKiFgNnVZxy8+zucv8mMfk44ZwQ78jUmAUBSv4Y=;
 b=wDJzAdGd8uCNDJamF9IHUvlTtrBLE8gbB3Nz2CzoKhOeHadMU4w/Kfd5slUESC/l07
 0HEBDis28uJzcDwd3+5NaPUfOx/unH0uvGe77x1QZ+lyKO8hfni5JmeONyDnS1ywD62w
 NVn9FWxTDRRhk9KkTdsEKuXqOopArCI9WN3G48YzR82bPOGblTHtKfHx2hHl6QPf6MJX
 ojVWtrsbr0FwZhZaOFiH8QGBMeEo8su2ojRhLsOhP2Lq4S06PKUNuYBrGhh3m0bxyjvJ
 W7LpXN9T1lWRsCkCuO9/4tmkzEqpaGB+/DMU7ObkHcSJThzO5LbvccUDg7GhWn3oQ3BF
 Heyw==
X-Gm-Message-State: AOJu0Yx5k8eTUa4WfLuPzZIfUUpVQlrjj+urY08SP2L6mtziWUse4Iqi
 JgfFCRqLpisQ9d/HQaHT9RodSS9Y4dWjfMmJUmfKpN6Z6Y/Rv8XHl9f/kSKouXLAXdzHKW05/W+
 P87Hsc0w=
X-Gm-Gg: ASbGncve6cEgheu6p3GWxSKQRoDJqC7IKITuVtUjC9ty6cR8ZC7F3TsjrAUF+Gz4pDG
 Q4kik58fxlJR0dPnWAeGbPs3Fl8IMJ06x2IhXW9rglaDavqpA/peioPzK/EOVnM4ilFSUq8jlUc
 yEDYeA7QMb49iEaPKUa23/X99aobrYQFJcqF3xuzdugcZYfpnq+YgAfSRr++wSKT1gUHcggVkrG
 NOCYQpZfcRSsX2j+ReoW9LClkluNqb+4ch3sHzjVXYoCNXdXwleq//1AYuXZ5HP+hQoD63fQMib
 5g13xlS8sb4m+5lFHIxAtRGVUPLSTJBeGYC9v7BIAHja03+Mnn0fHYWByWjPe8g4w37Gm3PGmwg
 r2dalVELFAfyIyFKJMm73nmMNBqcFS9HPcDqZpbvkYGQOZFD2oJ3yHnTAZi0B/KAR34JDLYrtdn
 46RKbEx76iliKicAKVVg6I5D+3OGZk5mopa053thAfxVc=
X-Google-Smtp-Source: AGHT+IFrMo8+TQYyWXGlKHCRZRUdCQDxufMCfPOAvp5n/B45iP4kkZyNhBpupiZPmTJLvUirGfT5Ag==
X-Received: by 2002:a17:902:f647:b0:279:daa1:676d with SMTP id
 d9443c01a7336-290c9c89cecmr238685345ad.8.1761235753823; 
 Thu, 23 Oct 2025 09:09:13 -0700 (PDT)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2946de1a6e3sm27745295ad.52.2025.10.23.09.09.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 09:09:13 -0700 (PDT)
Date: Thu, 23 Oct 2025 09:09:11 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Serhii Iliushyk <sil-plv@napatech.com>
Cc: dev@dpdk.org, thomas@monjalon.net, mko-plv@napatech.com, ckm@napatech.com
Subject: Re: [PATCH v1 1/1] doc: refactoring the guide for NTNIC PMD
Message-ID: <20251023090911.37c1f22a@phoenix>
In-Reply-To: <20251022164015.507050-2-sil-plv@napatech.com>
References: <9256303.5OynTdThKG@thomas>
 <20251022164015.507050-1-sil-plv@napatech.com>
 <20251022164015.507050-2-sil-plv@napatech.com>
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

On Wed, 22 Oct 2025 18:40:14 +0200
Serhii Iliushyk <sil-plv@napatech.com> wrote:

>  
>  Features
>  --------
> -
> -- FW version
> -- Speed capabilities
> -- Link status (Link update only)
> -- Unicast MAC filter
> -- Multicast MAC filter
> -- Promiscuous mode (Enable only. The device always run promiscuous mode)
> -- Flow API support.
> -- Support for multiple rte_flow groups.
> -- Multiple TX and RX queues.
> -- Scattered and gather for TX and RX.
> -- Jumbo frame support.
> -- Traffic mirroring.
> -- VLAN filtering.
> -- Packet modification: NAT, TTL decrement, DSCP tagging
> -- Tunnel types: GTP.
> -- Encapsulation and decapsulation of GTP data.
> -- RX VLAN stripping via raw decap.
> -- TX VLAN insertion via raw encap.
> -- CAM and TCAM based matching.
> -- Exact match of 140 million flows and policies.
> -- Tunnel HW offload: Packet type, inner/outer RSS, IP and UDP checksum verification.
> -- RSS hash
> -- RSS key update
> -- RSS based on VLAN or 5-tuple.
> -- RSS using different combinations of fields: L3 only, L4 only or both,
> -  and source only, destination only or both.
> -- Several RSS hash keys, one for each flow type.
> -- Default RSS operation with no hash key specification.
> -- Port and queue statistics.
> -- RMON statistics in extended stats.
> -- Link state information.
> -- Flow statistics
> -- Flow aging support
> -- Flow metering, including meter policy API.
> -- Flow update. Update of the action list for specific flow
> -- Asynchronous flow support
> -- MTU update
> +.. rst-class:: punchcard
> +
> +================================================================================================================ =======
> +Supported Features                                                                                                Linux
> +================================================================================================================ =======
> +FW version                                                                                                          X
> +Speed capabilities                                                                                                  X
> +Link status (Link update only)                                                                                      X
> +Unicast MAC filter                                                                                                  X
> +Multicast MAC filter                                                                                                X
> +Promiscuous mode (Enable only. The device always run promiscuous mode)                                              X
> +Flow API support.                                                                                                   X
> +Support for multiple rte_flow groups.                                                                               X
> +Multiple TX and RX queues.                                                                                          X
> +Scattered and gather for TX and RX.                                                                                 X
> +Jumbo frame support.                                                                                                X
> +Traffic mirroring.                                                                                                  X
> +VLAN filtering.                                                                                                     X
> +Packet modification: NAT, TTL decrement, DSCP tagging                                                               X
> +Tunnel types: GTP.                                                                                                  X
> +Encapsulation and decapsulation of GTP data.                                                                        X
> +RX VLAN stripping via raw decap.                                                                                    X
> +TX VLAN insertion via raw encap.                                                                                    X
> +CAM and TCAM based matching.                                                                                        X
> +Exact match of 140 million flows and policies.                                                                      X
> +Tunnel HW offload: Packet type, inner/outer RSS, IP and UDP checksum verification.                                  X
> +RSS hash                                                                                                            X
> +RSS key update                                                                                                      X
> +RSS based on VLAN or 5*tuple.                                                                                       X
> +RSS using different combinations of fields: L3 only, L4 only or both, and source only, destination only or both.    X
> +Several RSS hash keys, one for each flow type.                                                                      X
> +Default RSS operation with no hash key specification.                                                               X
> +Port and queue statistics.                                                                                          X
> +RMON statistics in extended stats.                                                                                  X
> +Link state information.                                                                                             X
> +Flow statistics                                                                                                     X
> +Flow aging support                                                                                                  X
> +Flow metering, including meter policy API.                                                                          X
> +Flow update. Update of the action list for specific flow                                                            X
> +Asynchronous flow support                                                                                           X
> +MTU update                                                                                                          X
> +================================================================================================================ =======

Why is this table needed. Most of this is already in NIC features table and having a duplicate
is redundant.
