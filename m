Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E5BC7EE30
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Jun 2025 12:16:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E332540BA0;
	Wed, 25 Jun 2025 14:16:16 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 4B4B8402AB
 for <dev@dpdk.org>; Wed, 25 Jun 2025 14:16:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750853774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HQvc9XfmOLrvCixzWU4twlIF8jtmAB4Rpd3e4TLH8NI=;
 b=UysNTWZ+BJTfdQ85zNXbFjyDmN2nPd8C9yjIcj4kKmct1JrXyqOLkEwWZosTuTUtuRs6E/
 z1kB+tRqBPalLtVYwiz6bsc4dZTsF4fr5yinSJhS1ZQ1IBpwsd7VW3xRagOwNiSN1C8Vju
 MOIlerwpgwPx08DlGetK23dcBMyJ+Os=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-241-f1LwptHFPkqt-a83TTdRmA-1; Wed,
 25 Jun 2025 08:16:13 -0400
X-MC-Unique: f1LwptHFPkqt-a83TTdRmA-1
X-Mimecast-MFC-AGG-ID: f1LwptHFPkqt-a83TTdRmA_1750853772
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8F98F19560A7; Wed, 25 Jun 2025 12:16:12 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.65.3])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5C33D19560B0; Wed, 25 Jun 2025 12:16:11 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org,  Michael Santana <maicolgabriel@hotmail.com>
Subject: Re: [PATCH 01/10] ci: save ccache on failure
In-Reply-To: <20250619071037.37325-2-david.marchand@redhat.com> (David
 Marchand's message of "Thu, 19 Jun 2025 09:10:27 +0200")
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250619071037.37325-2-david.marchand@redhat.com>
Date: Wed, 25 Jun 2025 08:16:09 -0400
Message-ID: <f7tldpgxbhy.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: a4j0KRCph86cc1hZBa2m-zHEbOWNhBIQANvMWRTGiWY_1750853772
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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

David Marchand <david.marchand@redhat.com> writes:

> When troubleshooting unit test failures and repeating jobs in GHA,
> the absence of ccache makes the whole process way slower.
>
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---

Acked-by: Aaron Conole <aconole@redhat.com>

>  .github/workflows/build.yml | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/.github/workflows/build.yml b/.github/workflows/build.yml
> index e5f17ef6ac..6c4bc664d0 100644
> --- a/.github/workflows/build.yml
> +++ b/.github/workflows/build.yml
> @@ -164,6 +164,12 @@ jobs:
>          chmod o-w $HOME
>      - name: Build and test
>        run: .ci/linux-build.sh
> +    - name: Save ccache on failure
> +      if: failure()
> +      uses: actions/cache/save@v4
> +      with:
> +        path: ~/.ccache
> +        key: ${{ steps.get_ref_keys.outputs.ccache }}-${{ github.ref }}
>      - name: Upload logs on failure
>        if: failure()
>        uses: actions/upload-artifact@v4

