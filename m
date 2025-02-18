Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1475AC021AA
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Feb 2025 13:32:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 06185402C4;
	Tue, 18 Feb 2025 14:32:37 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 2D0FA402A0
 for <dev@dpdk.org>; Tue, 18 Feb 2025 14:32:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739885554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HmRZhnj3Rk8W/1ChAS731pTjboZfIWWQVB1tUykiavg=;
 b=A5NpX5eukug2AgWXDu274mHD3jiHZ7rebJ1csk8+5yIr8lwz4XK81ElXxwARyYP+VJLpvV
 NemfniM1Wldr2QCNpdVXt9JJ1V2xTetAJZqT8eKoDARJ5Ua035FXGlgQ2FQyaWRRqun5rb
 +6BCd0H5DL4jsgSTPVFHmbwpO5Xw2qY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-27-LemSvVxBNH27ph31Eke4xg-1; Tue,
 18 Feb 2025 08:32:31 -0500
X-MC-Unique: LemSvVxBNH27ph31Eke4xg-1
X-Mimecast-MFC-AGG-ID: LemSvVxBNH27ph31Eke4xg_1739885550
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 64EC7193578F; Tue, 18 Feb 2025 13:32:30 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.80.189])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6C59419560A3; Tue, 18 Feb 2025 13:32:28 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org,  thomas@monjalon.net,  andremue@linux.microsoft.com,
 Michael Santana <maicolgabriel@hotmail.com>
Subject: Re: [PATCH] ci: build with MSVC in GHA
In-Reply-To: <20250213075010.2670431-1-david.marchand@redhat.com> (David
 Marchand's message of "Thu, 13 Feb 2025 08:50:10 +0100")
References: <20250213075010.2670431-1-david.marchand@redhat.com>
Date: Tue, 18 Feb 2025 08:32:26 -0500
Message-ID: <f7teczvbcph.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MPjETTyNGomQtUY1OdscrQ9ga_KI80WlwJmEx0YGzY8_1739885550
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

> Add a build target in Windows 2022 for MSVC.
>
> Loading MSVC environment and having successive commands in a single
> (cmd or pwsh) shell does not seem to correctly report if one of the
> commands failed.
> For now, load MSVC environment and run commands in separate shells.
>
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---

LGTM.

Acked-by: Aaron Conole <aconole@redhat.com>

How far back will this work (ie: can we backport this to older branches?)

>  .github/workflows/build.yml | 38 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>
> diff --git a/.github/workflows/build.yml b/.github/workflows/build.yml
> index dcafb4a8f5..aef692ca1f 100644
> --- a/.github/workflows/build.yml
> +++ b/.github/workflows/build.yml
> @@ -174,6 +174,44 @@ jobs:
>            build/meson-logs/meson-log.txt
>            build/meson-logs/testlog.txt
>  
> +  windows-vm-builds:
> +    name: ${{ join(matrix.config.*, '-') }}
> +    runs-on: ${{ matrix.config.os }}
> +    strategy:
> +      fail-fast: false
> +      matrix:
> +        config:
> +          - os: windows-2022
> +            compiler: msvc
> +
> +    steps:
> +    - name: Checkout sources
> +      uses: actions/checkout@v4
> +    - name: Set up Python
> +      uses: actions/setup-python@v5
> +      with:
> +        python-version: '3.x'
> +    - name: Install dependencies
> +      run: python -m pip install meson==1.6.1 ninja
> +    - name: Configure
> +      shell: cmd
> +      run: |
> +        call "C:\Program Files\Microsoft Visual Studio\2022\Enterprise\Common7\Tools\VsDevCmd.bat" -host_arch=amd64 -arch=amd64
> +        meson setup -Denable_stdatomic=true build
> +    - name: Build
> +      shell: cmd
> +      run: |
> +        call "C:\Program Files\Microsoft Visual Studio\2022\Enterprise\Common7\Tools\VsDevCmd.bat" -host_arch=amd64 -arch=amd64
> +        meson compile -C build
> +    - name: Upload logs on failure
> +      if: failure()
> +      uses: actions/upload-artifact@v4
> +      with:
> +        name: meson-logs-${{ join(matrix.config.*, '-') }}
> +        path: |
> +          build/.ninja_log
> +          build/meson-logs/meson-log.txt
> +
>    prepare-container-images:
>      name: ${{ join(matrix.config.*, '-') }}
>      runs-on: ubuntu-latest

