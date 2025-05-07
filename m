Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E72D3C3ABBF
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 May 2025 14:21:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D871C4025D;
	Wed,  7 May 2025 16:21:19 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 2EA854025A
 for <dev@dpdk.org>; Wed,  7 May 2025 16:21:18 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id F2CB12115DDF; Wed,  7 May 2025 07:21:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F2CB12115DDF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1746627677;
 bh=/fjh37/YIKimeHsuAvz5Z06oL8xh8qHPqM88GSBYSV0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Ods3yJgjbcm/oCJv+zHvvk+/7D7HvsmYfg6eSfEjmhVO6VdzTQJSBmLHKYBrl6P77
 QBaKYgdmd79D7Q8baovSWyyYdEZDMxJgZFeaOqvr8mDYwOLHD0qwoGiSUtXj/1ACtz
 CjtifWEl25rO3VwphYeIspPfdN+BUrYGLs4fof1Y=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org
Subject: [PATCH v3 0/1] avoid break due to failure to cleanup temporary
 directory
Date: Wed,  7 May 2025 07:21:10 -0700
Message-Id: <1746627671-28659-1-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1746474405-5056-1-git-send-email-andremue@linux.microsoft.com>
References: <1746474405-5056-1-git-send-email-andremue@linux.microsoft.com>
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

When compiling drivers on Windows, instances have been seen where a
temporary directory fails to get cleaned up due to
ERROR_SHARING_VIOLATION (32).

This issue was not seen on operating systems other than Windows.

This patch eliminates the use of tempfile.TemporaryDirectory, which
was triggering the issue.

For completeness, the error message is included below.

--- stderr ---
Traceback (most recent call last):
  File "C:\Program Files\WindowsApps\PythonSoftwareFoundation.Python.3.13_3.13.1008.0_x64__qbz5n2kfra8p0\Lib\shutil.py", line 631, in _rmtree_unsafe
    os.rmdir(path)
    ~~~~~~~~^^^^^^
PermissionError: [WinError 32] The process cannot access the file because it is being used by another process: 'V:\\github\\dpdk15\\dpdk\\build\\buildtools\\tmpnrqvi9nc'

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "C:\Program Files\WindowsApps\PythonSoftwareFoundation.Python.3.13_3.13.1008.0_x64__qbz5n2kfra8p0\Lib\tempfile.py", line 909, in onexc
    _os.unlink(path)
    ~~~~~~~~~~^^^^^^
PermissionError: [WinError 5] Access is denied: 'V:\\github\\dpdk15\\dpdk\\build\\buildtools\\tmpnrqvi9nc'

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "V:\github\dpdk15\dpdk\buildtools\gen-pmdinfo-cfile.py", line 13, in <module>
    with tempfile.TemporaryDirectory(dir=tmp_root) as temp:
         ~~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^
  File "C:\Program Files\WindowsApps\PythonSoftwareFoundation.Python.3.13_3.13.1008.0_x64__qbz5n2kfra8p0\Lib\tempfile.py", line 950, in __exit__
    self.cleanup()
    ~~~~~~~~~~~~^^
  File "C:\Program Files\WindowsApps\PythonSoftwareFoundation.Python.3.13_3.13.1008.0_x64__qbz5n2kfra8p0\Lib\tempfile.py", line 954, in cleanup
    self._rmtree(self.name, ignore_errors=self._ignore_cleanup_errors)
    ~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "C:\Program Files\WindowsApps\PythonSoftwareFoundation.Python.3.13_3.13.1008.0_x64__qbz5n2kfra8p0\Lib\tempfile.py", line 934, in _rmtree
    _shutil.rmtree(name, onexc=onexc)
    ~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^
  File "C:\Program Files\WindowsApps\PythonSoftwareFoundation.Python.3.13_3.13.1008.0_x64__qbz5n2kfra8p0\Lib\shutil.py", line 790, in rmtree
    return _rmtree_unsafe(path, onexc)
  File "C:\Program Files\WindowsApps\PythonSoftwareFoundation.Python.3.13_3.13.1008.0_x64__qbz5n2kfra8p0\Lib\shutil.py", line 635, in _rmtree_unsafe
    onexc(os.rmdir, path, err)
    ~~~~~^^^^^^^^^^^^^^^^^^^^^
  File "C:\Program Files\WindowsApps\PythonSoftwareFoundation.Python.3.13_3.13.1008.0_x64__qbz5n2kfra8p0\Lib\tempfile.py", line 924, in onexc
    cls._rmtree(path, ignore_errors=ignore_errors,
    ~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                repeated=(path == name))
                ^^^^^^^^^^^^^^^^^^^^^^^^
  File "C:\Program Files\WindowsApps\PythonSoftwareFoundation.Python.3.13_3.13.1008.0_x64__qbz5n2kfra8p0\Lib\tempfile.py", line 934, in _rmtree
    _shutil.rmtree(name, onexc=onexc)
    ~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^
  File "C:\Program Files\WindowsApps\PythonSoftwareFoundation.Python.3.13_3.13.1008.0_x64__qbz5n2kfra8p0\Lib\shutil.py", line 790, in rmtree
    return _rmtree_unsafe(path, onexc)
  File "C:\Program Files\WindowsApps\PythonSoftwareFoundation.Python.3.13_3.13.1008.0_x64__qbz5n2kfra8p0\Lib\shutil.py", line 635, in _rmtree_unsafe
    onexc(os.rmdir, path, err)
    ~~~~~^^^^^^^^^^^^^^^^^^^^^
  File "C:\Program Files\WindowsApps\PythonSoftwareFoundation.Python.3.13_3.13.1008.0_x64__qbz5n2kfra8p0\Lib\shutil.py", line 631, in _rmtree_unsafe
    os.rmdir(path)
    ~~~~~~~~^^^^^^
PermissionError: [WinError 32] The process cannot access the file because it is being used by another process: 'V:\\github\\dpdk15\\dpdk\\build\\buildtools\\tmpnrqvi9nc'

[53/450] Compiling C object lib/librte_pcapng.a.p/pcapng_rte_pcapng.c.obj
ninja: build stopped: subcommand failed.

v3:
- removed parameter tmp_root from gen-pmdinfo-cfile.py
- modified gen-pmdinfo-cfile.py to create '@PRIVATE_DIR@' when it does not exist.

v2:
- removed use of Python's tempfile.TemporaryDirectory and used
  '@PRIVATE_DIR@' in meson's custom_target command instead.

Andre Muezerie (1):
  buildtools: avoid break due to failure to cleanup temporary directory

 buildtools/gen-pmdinfo-cfile.py | 26 +++++++++++++-------------
 buildtools/meson.build          |  2 +-
 drivers/meson.build             |  2 +-
 3 files changed, 15 insertions(+), 15 deletions(-)

--
2.49.0.vfs.0.2

